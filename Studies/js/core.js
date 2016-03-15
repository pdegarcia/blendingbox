/********* FORMS HANDLERS *********/

$("#ratingForm").submit(function(event) {
  // TODO: SUBMIT RATING
  event.preventDefault();
  submitForm();
});

function submitForm() {
  // TODO: PHP
  // TODO: INC CONTADORES DE QUESTÃO
  // TODO: MUDAR QUESTÃO e eliminar questão actual
  // TODO: RANDOM
}

/********* GLOBAL VARIABLES *********/

var selectdiv;

var countClicks = 0;
var countQuestions = 0;
var start = new Date();

var type0QuestionSet = [];
var type1QuestionSet = [];
var numberOfQuestions = 1;
var currentQuestion = 1;
var currentQuestionObject;

function incCountClicks() {
  console.log("Count clicks inc!");
  countClicks++;
}

function incNumberOfQuestions() {
  numberOfQuestions++;
}

function submitColors() {
  // TODO: SUBMIT COLORS PHP
  var ended = Math.round((new Date() - start) / 1000);
}

/********* DATA POPULATE *********/

//Load Questions data.
d3.json("../data/questions.json", function(error, json) {
  if (error) return console.warn(error);
  else {
    for (var k in json) {
      switch (json[k].typeOf) { //DEPENDING ON TYPE OF QUESTION.
        case "objTwoColors":    // MIXTURE = COLOR + COLOR
          console.log("type 0!");
          type0QuestionSet.push(json[k]);
          break;
        case "twoColorsObj":    // COLOR + COLOR = MIXTURE
          console.log("type 1!");
          type1QuestionSet.push(json[k]);
          break;
      }
    }
    numberOfQuestions = json.length - 1; //BECAUSE 0.
    populateMixtureArea();
  }
});

function populateMixtureArea() {
  var index = 0;

  $("#questionNumber").append("Questão " + currentQuestion + " de " + numberOfQuestions);

  switch (selectdiv) {
    case 0:     // MIXTURE = COLOR + COLOR
      index = Math.floor(Math.random() * (type0QuestionSet.length));
      currentQuestionObject = type0QuestionSet[index];
      break;
    case 1:     // COLOR + COLOR = MIXTURE
      index = Math.floor(Math.random() * (type1QuestionSet.length));
      currentQuestionObject = type1QuestionSet[index];
      break;
  }

  // TODO: INCLUDE ENGLISH APPEND
  $("#questionField").append(currentQuestionObject.questionPT);
  d3.select(".obj_color_shape" + (selectdiv)).select("circle").attr("fill", currentQuestionObject.colorObjective);
  d3.select(".first_color_shape" + (selectdiv)).select("circle").attr("fill", currentQuestionObject.firstColor);
  d3.select(".second_color_shape" + (selectdiv)).select("circle").attr("fill", currentQuestionObject.secondColor);
}

/********* D3 FUNCTIONS *********/

function resetMixture() {
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

function drawObjective() {
  /* VARS TO OBJECTIVE */
  var wObj = $(".obj_color_shape" + (selectdiv)).width();
  var hObj = $(".obj_color_shape" + (selectdiv)).height();
  var margin = {
    top: 20,
    right: 150,
    bottom: 20,
    left: 20
  };

  var objShape = d3.select(".obj_color_shape" + (selectdiv))
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

function drawFirstColor() {

  /* VARS TO FIRST COLOR MIXTURE */
  var wFirst = $(".first_color_shape" + (selectdiv)).width();
  var hFirst = $(".first_color_shape" + (selectdiv)).height();
  var margin = {
    top: 20,
    right: 150,
    bottom: 20,
    left: 20
  };

  var fstShape = d3.select(".first_color_shape" + (selectdiv))
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

function drawSecColor() {

  /* VARS TO SECOND COLOR MIXTURE */
  var wSec = $(".second_color_shape" + (selectdiv)).width();
  var hSec = $(".second_color_shape" + (selectdiv)).height();
  var margin = {
    top: 20,
    right: 150,
    bottom: 20,
    left: 20
  };

  var secShape = d3.select(".second_color_shape" + (selectdiv))
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
function drawFirstSlider() {

  /* VARS TO SET SVG CANVAS*/
  var margin = {
    top: 20,
    right: 150,
    bottom: 20,
    left: 5
  };
  var wSlid = $(".slider_one" + (selectdiv)).width();
  var hSlid = $(".slider_one" + (selectdiv)).height();

  var scaleX = d3.scale.linear()
    .domain([0, 360])
    .range([0, wSlid])
    .clamp(true);

  var brush = d3.svg.brush()
    .x(scaleX)
    .extent([0, 0])
    .on("brush", brushed);

  var sliderBar = d3.select(".slider_one" + (selectdiv)).append("svg")
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
    var colorShape = ".first_color_shape" + (selectdiv) + " svg";
    var svg = d3.select(colorShape);
    var circle = svg.select("circle");

    if (d3.event.sourceEvent) { // not a programmatic event
      value = scaleX.invert(d3.mouse(this)[0]);
      brush.extent([value, value]);
    }
    handle.attr("cx", scaleX(value));

    if (value === 0) { //Default config = white
      circle.attr("fill", d3.hsl(360, 1, 1));
    } else {
      incCountClicks();
      circle.attr("fill", d3.hsl(value, 1, 0.50));
    }

  }
}

/* FUNCTION TO DRAW SECOND SLIDER AND HANDLE ITS MOVEMENT */
function drawSecondSlider() {

  /* VARS TO SET SVG CANVAS*/
  var margin = {
    top: 20,
    right: 150,
    bottom: 20,
    left: 5
  };
  var wSlid = $(".slider_two" + (selectdiv)).width();
  var hSlid = $(".slider_two" + (selectdiv)).height();

  var scaleX = d3.scale.linear()
    .domain([0, 360])
    .range([0, wSlid])
    .clamp(true);

  var brush = d3.svg.brush()
    .x(scaleX)
    .extent([0, 0])
    .on("brush", brushed);

  var sliderBar = d3.select(".slider_two" + (selectdiv)).append("svg")
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
    var colorShape = ".second_color_shape" + (selectdiv) + " svg";
    var svg = d3.select(colorShape);
    var circle = svg.select("circle");

    if (d3.event.sourceEvent) { // not a programmatic event
      value = scaleX.invert(d3.mouse(this)[0]);
      brush.extent([value, value]);
    }
    handle.attr("cx", scaleX(value));

    if (value === 0) { //Default config = white
      circle.attr("fill", d3.hsl(360, 1, 1));
    } else {
      circle.attr("fill", d3.hsl(value, 1, 0.50));
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
    left: 5
  };
  var wSlid = $(".slider_objective" + (selectdiv)).width();
  var hSlid = $(".slider_objective" + (selectdiv)).height();

  var scaleX = d3.scale.linear()
    .domain([0, 360])
    .range([0, wSlid])
    .clamp(true);

  var brush = d3.svg.brush()
    .x(scaleX)
    .extent([0, 0])
    .on("brush", brushed);

  var sliderBar = d3.select(".slider_objective" + (selectdiv)).append("svg")
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
    var colorShape = ".obj_color_shape" + (selectdiv) + " svg";
    var svg = d3.select(colorShape);
    var circle = svg.select("circle");

    if (d3.event.sourceEvent) { // not a programmatic event
      value = scaleX.invert(d3.mouse(this)[0]);
      brush.extent([value, value]);
    }
    handle.attr("cx", scaleX(value));

    if (value === 0) { //Default config = white
      circle.attr("fill", d3.hsl(360, 1, 1));
    } else {
      circle.attr("fill", d3.hsl(value, 1, 0.50));
    }

  }
}

!(function(d3) {

  selectdiv = new Date().getTime() % 2;
  $("#mixture" + (selectdiv)).css("display", "block");

  /* SHAPES */
  drawObjective();
  drawFirstColor();
  drawSecColor();

  /* SLIDERS */
  drawFirstSlider();
  drawSecondSlider();
  drawObjectiveSlider();

})(d3);
