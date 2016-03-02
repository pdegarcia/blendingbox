function resetMixture() {
  var handle1 = d3.select(".slider_one circle");
  var handle2 = d3.select(".slider_two circle");

}

function drawObjective() {

  /* VARS TO OBJECTIVE */
  var wObj = $(".obj_color_shape").width();
  var hObj = $(".obj_color_shape").height();
  var margin = {top: 20, right: 150, bottom: 20, left: 20};

  var objShape = d3.select(".obj_color_shape")
            .append("svg:svg")
            .attr("width", wObj)
            .attr("height", hObj);

  objShape.append("circle")
          .attr("r", wObj*0.3)
          .attr("cx", wObj*0.45 + margin.left)
          .attr("cy", hObj*0.5 + margin.top)
          .attr("fill", "#00FF00")
          .style("stroke", "black");
}

function drawFirstColor() {

  /* VARS TO FIRST COLOR MIXTURE */
  var wFirst = $(".first_color_shape").width();
  var hFirst = $(".first_color_shape").height();
  var margin = {top: 20, right: 150, bottom: 20, left: 20};

  var fstShape = d3.select(".first_color_shape")
                      .append("svg")
                      .attr("width", wFirst)
                      .attr("height", hFirst)
                      .attr("fill", "none");

  fstShape.append("circle")
          .attr("r", wFirst*0.3)
          .attr("cx", wFirst*0.45 + margin.left)
          .attr("cy", hFirst*0.5 + margin.top)
          .attr("fill", "none")
          .style("stroke", "black")
          .style("background-color", "none");
}

function drawSecColor() {

  /* VARS TO SECOND COLOR MIXTURE */
  var wSec = $(".second_color_shape").width();
  var hSec = $(".second_color_shape").height();
  var margin = {top: 20, right: 150, bottom: 20, left: 20};

  var secShape = d3.select(".second_color_shape")
                    .append("svg")
                    .attr("width", wSec)
                    .attr("height", hSec);

  secShape.append("circle")
          .attr("r", wSec*0.3)
          .attr("cx", wSec*0.45 + margin.left)
          .attr("cy", hSec*0.5 + margin.top)
          .attr("fill", "white")
          .style("stroke", "black");
}

/* FUNCTION TO DRAW FIRST SLIDER AND HANDLE ITS MOVEMENT */
function drawFirstSlider() {

  /* VARS TO SET SVG CANVAS*/
  var margin = {top: 20, right: 150, bottom: 20, left: 5};
  var wSlid = $(".slider_one").width();
  var hSlid = $(".slider_one").height();

  var scaleX = d3.scale.linear()
                       .domain([0, 360])
                       .range([0, wSlid])
                       .clamp(true);

  var brush = d3.svg.brush()
                     .x(scaleX)
                     .extent([0, 0])
                     .on("brush", brushed);

  var sliderBar = d3.select(".slider_one").append("svg")
                 .attr("width", wSlid + margin.left + margin.right)
                 .attr("height", hSlid + margin.top + margin.bottom)
                 .append("g")
                 .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

  sliderBar.append("g")
           .attr("class", "x axis")
           .attr("transform", "translate(0," + hSlid/2 + ")")
           .call(d3.svg.axis()
                 .scale(scaleX)
                 .orient("bottom")
                 .tickFormat(function(d) { return d; })
                 .tickSize(0)
                 .tickPadding(10))
           .select(".domain")
           .select(function() { return this.parentNode.appendChild(this.cloneNode(true)); })
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
        .call(brush.extent([180, 180]))
        .call(brush.event);

  function brushed() {
      var value = brush.extent()[0];
      var svg = d3.select(".first_color_shape svg");
      var circle = svg.select("circle");

      if (d3.event.sourceEvent) { // not a programmatic event
        value = scaleX.invert(d3.mouse(this)[0]);
        brush.extent([value, value]);
      }
      handle.attr("cx", scaleX(value));
      circle.attr("fill", d3.hsl(value, 1, 0.50));

  }
}

/* FUNCTION TO DRAW SECOND SLIDER AND HANDLE ITS MOVEMENT */
function drawSecondSlider() {

  /* VARS TO SET SVG CANVAS*/
  var margin = {top: 20, right: 150, bottom: 20, left: 5};
  var wSlid = $(".slider_two").width();
  var hSlid = $(".slider_two").height();

  var scaleX = d3.scale.linear()
                       .domain([0, 360])
                       .range([0, wSlid])
                       .clamp(true);

  var brush = d3.svg.brush()
                     .x(scaleX)
                     .extent([0, 0])
                     .on("brush", brushed);

  var sliderBar = d3.select(".slider_two").append("svg")
                 .attr("width", wSlid + margin.left + margin.right)
                 .attr("height", hSlid + margin.top + margin.bottom)
                 .append("g")
                 .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

  sliderBar.append("g")
           .attr("class", "x axis")
           .attr("transform", "translate(0," + hSlid/2 + ")")
           .call(d3.svg.axis()
                 .scale(scaleX)
                 .orient("bottom")
                 .tickFormat(function(d) { return d; })
                 .tickSize(0)
                 .tickPadding(10))
           .select(".domain")
           .select(function() { return this.parentNode.appendChild(this.cloneNode(true)); })
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
        .call(brush.extent([180, 180]))
        .call(brush.event);

  function brushed() {
      var value = brush.extent()[0];
      var svg = d3.select(".second_color_shape svg");
      var circle = svg.select("circle");

      if (d3.event.sourceEvent) { // not a programmatic event
        value = scaleX.invert(d3.mouse(this)[0]);
        brush.extent([value, value]);
      }
      handle.attr("cx", scaleX(value));
      circle.style("fill", d3.hsl(value, 1, 0.50));

  }
}

!(function (d3) {

  /* SVG CANVAS DIMENSION */
  /*var margin = {top: h*0.05, right: w*0.025, bottom: h*0.05, left: w*0.06},
  width = w*0.45 - margin.left - margin.right,
  height = h*0.45 - margin.top - margin.bottom;*/

  /* SHAPES */
  drawObjective();
  drawFirstColor();
  drawSecColor();

  /* SLIDERS */
  drawFirstSlider();
  drawSecondSlider();


})(d3);
