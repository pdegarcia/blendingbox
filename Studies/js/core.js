/********* FORMS HANDLERS *********/

$('.rating').on('rating.change', function(event, value, caption) {
  document.getElementById('rating-button').style.visibility = 'visible';
});

$(function() {
  $('#rating-button').click(function() {
    var values = {
      typeOfQuestion: document.getElementById('typeOfQuestion').value,
      idQuestion: document.getElementById('numberOfQuestion').value,
      firstColor: document.getElementById('firstColor').value,
      secColor: document.getElementById('secColor').value,
      thirdColor: document.getElementById('thirdColor').value,
      numClicks: document.getElementById('numClicks').value,
      pageTime: document.getElementById('pageTime').value,
      stars: document.getElementById('stars').value,
      numResets: document.getElementById('numResets').value
    };
    $.ajax({
      type: "POST",
      url: phpURL,
      data: values,
      success: function(response) {},
      error: function(jqXHR, textStatus, errorThrown) {
        console.log(textStatus, errorThrown);
      }
    });
    return false;
  });
  $('#rating-button').click(function() {
    cleanStars();
    updateScreen();
  });
});

function cleanStars() {
  $('.filled-stars').css("width", "0%");
}

function updateScreen() {
  //STARS RESET
  document.getElementById('satisfaction').style.visibility = 'hidden';
  document.getElementById('rating-button').style.visibility = 'hidden';

  selectdiv = new Date().getTime() % 2;

  if ((selectdiv === 0) && (type0QuestionSet.length === 0)) { //se 0 empty
    if (type1QuestionSet.length !== 0) {
      selectdiv = 1;
    } else {
      window.location = pathToFinish;
    }
  }

  if ((selectdiv === 1) && (type1QuestionSet.length === 0)) { //se 0 empty
    if (type0QuestionSet.length !== 0) {
      selectdiv = 0;
    } else {
      window.location = pathToFinish;
    }
  }

  switch (selectdiv) {
    case 0:
      $("#mixture0").css("display", "block");
      $("#mixture1").css("display", "none");
      break;
    case 1:
      $("#mixture0").css("display", "none");
      $("#mixture1").css("display", "block");
      break;
  }

  resetMixture();

  countClicks = 0;
  countResets = 0;
  document.getElementById('firstColor').value = "NONE";
  document.getElementById('secColor').value = "NONE";
  document.getElementById('thirdColor').value = "NONE";
  start = new Date();
  incCurrentQuestion();

  populateMixtureArea();

}

/********* GLOBAL VARIABLES *********/

var selectdiv;
var path;
var pathColors;
var pathToFinish;
var phpURL;

var countClicks = 0;
var countResets = 0;
var start = new Date();

var type0QuestionSet = [];
var type1QuestionSet = [];
var colorSet = [];
var numberOfQuestions = 1;
var currentQuestion = 1;
var currentQuestionObject;

function incCountClicks() {
  countClicks++;
}

function incCurrentQuestion() {
  currentQuestion++;
}

function submitColors() {
  var ended = Math.round((new Date() - start) / 1000);
  document.getElementById('numClicks').value = countClicks;
  document.getElementById('pageTime').value = ended;
  document.getElementById('numResets').value = countResets;

  document.getElementById('satisfaction').style.visibility = 'visible';
}

/********* DATA POPULATE *********/

switch (document.documentElement.lang) { //handle JSON location.
  case 'pt':
    path = "../data/questions.json";
    pathToFinish = "../html/thankyou.html";
    phpURL = "../php/addCoreForm.php";
    pathColors = "../data/populateSlider.json";
    break;
  case 'en':
    path = "../../data/questions.json";
    pathToFinish = "../en/thankyou.html";
    phpURL = "../../php/addCoreForm.php";
    pathColors = "../../data/populateSlider.json";
    break;
  default:
    path = "../../data/questions.json"; //Langs to come.
}

//Load Questions data.
d3.json(path, function(error, json) {
  if (error) return console.warn(error);
  else {
    for (var k in json) {
      switch (json[k].typeOf) { //DEPENDING ON TYPE OF QUESTION.
        case "objTwoColors": // MIXTURE = COLOR + COLOR
          type0QuestionSet.push(json[k]);
          break;
        case "twoColorsObj": // COLOR + COLOR = MIXTURE
          type1QuestionSet.push(json[k]);
          break;
      }
    }
    numberOfQuestions = json.length;
    populateMixtureArea();
  }
});

d3.json(pathColors, function(error, json) {
  if (error) return console.warn(error);
  else {
    for (var k in json) {
      colorSet.push(json[k]);
    }
  }
});

function populateMixtureArea() {
  var index = 0;

  switch (selectdiv) {
    case 0: // MIXTURE = COLOR + COLOR
      index = Math.floor(Math.random() * (type0QuestionSet.length));
      currentQuestionObject = type0QuestionSet[index];
      type0QuestionSet.splice(index, 1);
      document.getElementById('firstColor').value = currentQuestionObject.colorObjective;
      break;
    case 1: // COLOR + COLOR = MIXTURE
      index = Math.floor(Math.random() * (type1QuestionSet.length));
      currentQuestionObject = type1QuestionSet[index];
      type1QuestionSet.splice(index, 1);
      document.getElementById('firstColor').value = currentQuestionObject.firstColor;
      document.getElementById('secColor').value = currentQuestionObject.secondColor;
      break;
  }

  $("#questionNumber").empty();
  $("#questionField").empty();

  switch (document.documentElement.lang) {
    case 'pt':
      $("#questionNumber").append("Questão número " + currentQuestion + " de " + numberOfQuestions + ".");
      $("#questionField").append(currentQuestionObject.questionPT);
      break;
    case 'en':
      $("#questionNumber").append("Question number " + currentQuestion + " of " + numberOfQuestions + ".");
      $("#questionField").append(currentQuestionObject.questionEN);
      break;
  }

  document.getElementById('typeOfQuestion').value = currentQuestionObject.typeOf;
  document.getElementById('numberOfQuestion').value = currentQuestionObject.idQuestion;
  d3.select(".obj_color_shape" + (selectdiv)).select("circle").attr("fill", currentQuestionObject.colorObjective);
  d3.select(".first_color_shape" + (selectdiv)).select("circle").attr("fill", currentQuestionObject.firstColor);
  d3.select(".second_color_shape" + (selectdiv)).select("circle").attr("fill", currentQuestionObject.secondColor);
}

/********* D3 FUNCTIONS *********/

function resetMixture() {
  countResets++;

  var shapeOne = d3.select(".first_color_shape0").select("circle");
  var shapeTwo = d3.select(".second_color_shape0").select("circle");
  var shapeObj = d3.select(".obj_color_shape1").select("circle");
  var sliderOne = d3.select(".slider_one0").select("circle");
  var sliderTwo = d3.select(".slider_two0").select("circle");
  var sliderObj = d3.select(".slider_objective1").select("circle");

  // RESET COLORS (shapeOne & Two NULL if selectedDiv === 1)
  shapeOne.attr("fill", "#FFF");
  shapeTwo.attr("fill", "#FFF");
  shapeObj.attr("fill", "#FFF");

  // RESET POSITIONS (sliderOne & Two NULL if selectedDiv === 1)
  sliderOne.transition().duration("750").attr("cx", 0);
  sliderTwo.transition().duration("750").attr("cx", 0);
  sliderObj.transition().duration("750").attr("cx", 0);
}

function drawObjective(selectedDiv) {
  /* VARS TO OBJECTIVE */
  var wObj = $(".obj_color_shape" + (selectedDiv)).width();
  var hObj = $(".obj_color_shape" + (selectedDiv)).height();
  var margin = {
    top: 20,
    right: 150,
    bottom: 20,
    left: 20
  };

  var objShape = d3.select(".obj_color_shape" + (selectedDiv))
    .append("svg:svg")
    .attr("width", wObj)
    .attr("height", hObj);

  objShape.append("circle")
    .attr("r", wObj * 0.3)
    .attr("cx", wObj * 0.45 + margin.left)
    .attr("cy", hObj * 0.5 + margin.top)
    .attr("fill", "none")
    .attr("stroke-width", 2.5)
    .style("stroke", "black");

}

function drawFirstColor(selectedDiv) {

  /* VARS TO FIRST COLOR MIXTURE */
  var wFirst = $(".first_color_shape" + (selectedDiv)).width();
  var hFirst = $(".first_color_shape" + (selectedDiv)).height();
  var margin = {
    top: 20,
    right: 150,
    bottom: 20,
    left: 20
  };

  var fstShape = d3.select(".first_color_shape" + (selectedDiv))
    .append("svg")
    .attr("width", wFirst)
    .attr("height", hFirst)
    .attr("fill", "none");

  fstShape.append("circle")
    .attr("r", wFirst * 0.3)
    .attr("cx", wFirst * 0.45 + margin.left)
    .attr("cy", hFirst * 0.5 + margin.top)
    .attr("fill", "none")
    .attr("stroke-width", 2.5)
    .style("stroke", "black")
    .style("background-color", "none");
}

function drawSecColor(selectedDiv) {

  /* VARS TO SECOND COLOR MIXTURE */
  var wSec = $(".second_color_shape" + (selectedDiv)).width();
  var hSec = $(".second_color_shape" + (selectedDiv)).height();
  var margin = {
    top: 20,
    right: 150,
    bottom: 20,
    left: 20
  };

  var secShape = d3.select(".second_color_shape" + (selectedDiv))
    .append("svg")
    .attr("width", wSec)
    .attr("height", hSec);

  secShape.append("circle")
    .attr("r", wSec * 0.3)
    .attr("cx", wSec * 0.45 + margin.left)
    .attr("cy", hSec * 0.5 + margin.top)
    .attr("fill", "white")
    .attr("stroke-width", 2.5)
    .style("stroke", "black");
}

/* FUNCTION TO DRAW FIRST SLIDER AND HANDLE ITS MOVEMENT */
function drawFirstSlider(selectedDiv) {

  /* VARS TO SET SVG CANVAS*/
  var margin = {
    top: 20,
    right: 150,
    bottom: 20,
    left: 10
  };
  var wSlid = $(".slider_one" + (selectedDiv)).width();
  var hSlid = $(".slider_one" + (selectedDiv)).height();

  var scaleX = d3.scale.linear()
    .domain([0, 360])
    .range([0, wSlid])
    .clamp(true);

  var brush = d3.svg.brush()
    .x(scaleX)
    .extent([0, 0])
    .on("brush", brushed);

  var sliderBar = d3.select(".slider_one" + (selectedDiv)).append("svg")
    .attr("width", wSlid + margin.left + margin.right)
    .attr("height", hSlid + margin.top + margin.bottom)
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

  sliderBar.append("g")
    .attr("class", "x axis")
    .attr("transform", "translate(0," + hSlid / 2 + ")")
    .call(d3.svg.axis()
      .scale(scaleX)
      .orient("bottom")
      .tickFormat(function(d) {
        return "|";
      })
      .ticks(0) //SET NUMBER OF TICKS
      .tickSize(0)
      .tickPadding(5))
    .select(".domain")
    .select(function() {
      return this.parentNode.appendChild(this.cloneNode(true));
    })
    .attr("class", "halo");

  /* SLIDER BAR */
  var slider = sliderBar.append("g")
    .attr("class", "slider")
    .call(brush);

  slider.selectAll(".extent,.resize")
    .remove();

  slider.select(".background")
    .attr("height", hSlid);

  /* SLIDER HANDLE */
  var handle = slider.append("circle")
    .attr("class", "handle")
    .attr("transform", "translate(0," + hSlid / 2 + ")")
    .attr("r", 9);

  slider.call(brush.event)
    .transition()
    .duration(750)
    .call(brush.extent([0, 0]))
    .call(brush.event);

  function brushed() {
    var value = brush.extent()[0];
    var colorShape = ".first_color_shape" + (selectedDiv) + " svg";
    var svg = d3.select(colorShape);
    var circle = svg.select("circle");

    if (d3.event.sourceEvent) { // not a programmatic event
      value = scaleX.invert(d3.mouse(this)[0]);
      brush.extent([value, value]);
    }
    handle.attr("cx", scaleX(value));

    if (value === 0) { //Default config = white
      circle.attr("fill", d3.hsl(360, 1, 1));
      document.getElementById('thirdColor').value = "NONE";
    } else {
      circle.attr("fill", d3.hsl(value, 1, 0.50));
      incCountClicks();
      document.getElementById('secColor').value = "hsl(" + value + ",1,0.50)";
    }

  }
}

/* FUNCTION TO DRAW SECOND SLIDER AND HANDLE ITS MOVEMENT */
function drawSecondSlider(selectedDiv) {

  /* VARS TO SET SVG CANVAS*/
  var margin = {
    top: 20,
    right: 150,
    bottom: 20,
    left: 10
  };
  var wSlid = $(".slider_two" + (selectedDiv)).width();
  var hSlid = $(".slider_two" + (selectedDiv)).height();

  var scaleX = d3.scale.linear()
    .domain([0, 360])
    .range([0, wSlid])
    .clamp(true);

  var brush = d3.svg.brush()
    .x(scaleX)
    .extent([0, 0])
    .on("brush", brushed);

  var sliderBar = d3.select(".slider_two" + (selectedDiv)).append("svg")
    .attr("width", wSlid + margin.left + margin.right)
    .attr("height", hSlid + margin.top + margin.bottom)
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

  sliderBar.append("g")
    .attr("class", "x axis")
    .attr("transform", "translate(0," + hSlid / 2 + ")")
    .call(d3.svg.axis()
      .scale(scaleX)
      .orient("bottom")
      .tickFormat(function(d) {
        return "|";
      })
      .ticks(0)
      .tickSize(0)
      .tickPadding(10))
    .select(".domain")
    .select(function() {
      return this.parentNode.appendChild(this.cloneNode(true));
    })
    .attr("class", "halo");

  /* SLIDER BAR */
  var slider = sliderBar.append("g")
    .attr("class", "slider")
    .call(brush);

  slider.selectAll(".extent,.resize")
    .remove();

  slider.select(".background")
    .attr("height", hSlid);

  /* SLIDER HANDLE */
  var handle = slider.append("circle")
    .attr("class", "handle")
    .attr("transform", "translate(0," + hSlid / 2 + ")")
    .attr("r", 9);

  slider.call(brush.event)
    .transition()
    .duration(750)
    .call(brush.extent([0, 0]))
    .call(brush.event);

  function brushed() {
    var value = brush.extent()[0];
    var colorShape = ".second_color_shape" + (selectedDiv) + " svg";
    var svg = d3.select(colorShape);
    var circle = svg.select("circle");

    if (d3.event.sourceEvent) { // not a programmatic event
      value = scaleX.invert(d3.mouse(this)[0]);
      brush.extent([value, value]);
    }
    handle.attr("cx", scaleX(value));

    if (value === 0) { //Default config = white
      circle.attr("fill", d3.hsl(360, 1, 1));
      document.getElementById('thirdColor').value = "NONE";
    } else {
      circle.attr("fill", d3.hsl(value, 1, 0.50));
      document.getElementById('thirdColor').value = "hsl(" + value + ",1,0.50)";
      incCountClicks();
    }

  }
}

function drawObjectiveSlider() {

  /* VARS TO SET SVG CANVAS*/
  var margin = {
    top: 20,
    right: 150,
    bottom: 20,
    left: 10
  };
  var wSlid = $(".slider_objective1").width();
  var hSlid = $(".slider_objective1").height();

  var scaleX = d3.scale.linear()
    .domain([0, 47])
    .range([0, wSlid]) //tamanho slider - width
    .clamp(true);

  var brush = d3.svg.brush()
    .x(scaleX)
    .extent([0, 0])
    .on("brush", brushed);

  var sliderBar = d3.select(".slider_objective1").append("svg")
    .attr("width", wSlid + margin.left + margin.right)
    .attr("height", hSlid + margin.top + margin.bottom)
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

  sliderBar.append("g")
    .attr("class", "x axis")
    .attr("transform", "translate(0," + hSlid / 2 + ")")
    .call(d3.svg.axis()
      .scale(scaleX)
      .orient("bottom")
      .tickFormat(function(d) {
        return "|";
      })
      .ticks(0)
      .tickSize(0)
      .tickPadding(10))
    .select(".domain")
    .select(function() {
      return this.parentNode.appendChild(this.cloneNode(true));
    })
    .attr("class", "halo");

  /* SLIDER BAR */
  var slider = sliderBar.append("g")
    .attr("class", "slider")
    .call(brush);

  slider.selectAll(".extent,.resize")
    .remove();

  slider.select(".background")
    .attr("height", hSlid);

  /* SLIDER HANDLE */
  var handle = slider.append("circle")
    .attr("class", "handle")
    .attr("transform", "translate(0," + hSlid / 2 + ")")
    .attr("r", 9);

  slider.call(brush.event)
    .transition()
    .duration(750)
    .call(brush.extent([0, 0]))
    .call(brush.event);

  function brushed() {
    var value = brush.extent()[0];
    var colorShape = ".obj_color_shape1 svg";
    var svg = d3.select(colorShape);
    var circle = svg.select("circle");

    if (d3.event.sourceEvent) { // not a programmatic event
      value = scaleX.invert(d3.mouse(this)[0]);
      brush.extent([value, value]);
    }
    handle.attr("cx", scaleX(value));

    if (value === 0) { //Default config = white
      circle.attr("fill", "#FFFFFF");
      document.getElementById('thirdColor').value = "NONE";
    } else {
      circle.attr("fill", colorSet[Math.round(value)]);
      document.getElementById('thirdColor').value = colorSet[Math.round(value)];
      incCountClicks();
    }
  }
}

function initScreen() {

  selectdiv = new Date().getTime() % 2;

  switch (selectdiv) {
    case 0:
      $("#mixture0").css("display", "block");
      $("#mixture1").css("display", "none");
      break;
    case 1:
      $("#mixture0").css("display", "none");
      $("#mixture1").css("display", "block");
      break;
  }

  /* SHAPES */
  drawObjective(0);
  drawObjective(1);
  //Draw both mixtures
  drawFirstColor(0);
  drawFirstColor(1);

  drawSecColor(0);
  drawSecColor(1);

  /* SLIDERS */
  drawFirstSlider(0);
  drawFirstSlider(1);
  drawSecondSlider(0);
  drawSecondSlider(1);
  drawObjectiveSlider();
}

!(function(d3) {

  initScreen();

})(d3);
