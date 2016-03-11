
function resetMixture() {

  d3.select(".slider_one circle").attr("cx", 0)
                                 .attr("cy", 0)
                                 .attr("fill", d3.hsl(360, 1, 1));
  d3.select(".slider_two circle").attr("cx", 0)
                                 .attr("cy", 0)
                                 .attr("fill", "none");
}

function drawObjective(selectedDiv) {
  /* VARS TO OBJECTIVE */
  var wObj = $(".obj_color_shape"+(selectedDiv)).width();
  var hObj = $(".obj_color_shape" + (selectedDiv)).height();
  var margin = {top: 20, right: 150, bottom: 20, left: 20};

  var objShape = d3.select(".obj_color_shape"+(selectedDiv))
            .append("svg:svg")
            .attr("width", wObj)
            .attr("height", hObj);

  objShape.append("circle")
          .attr("r", wObj*0.3)
          .attr("cx", wObj*0.45 + margin.left)
          .attr("cy", hObj*0.5 + margin.top)
          .attr("fill", "#00FF00")
          .attr("stroke-width", 2.5)
          .style("stroke", "black");
}

function drawFirstColor(selectedDiv) {

  /* VARS TO FIRST COLOR MIXTURE */
  var wFirst = $(".first_color_shape"+(selectedDiv)).width();
  var hFirst = $(".first_color_shape"+(selectedDiv)).height();
  var margin = {top: 20, right: 150, bottom: 20, left: 20};

  var fstShape = d3.select(".first_color_shape"+(selectedDiv))
                      .append("svg")
                      .attr("width", wFirst)
                      .attr("height", hFirst)
                      .attr("fill", "none");

  fstShape.append("circle")
          .attr("r", wFirst*0.3)
          .attr("cx", wFirst*0.45 + margin.left)
          .attr("cy", hFirst*0.5 + margin.top)
          .attr("fill", "none")
          .attr("stroke-width", 2.5)
          .style("stroke", "black")
          .style("background-color", "none");
}

function drawSecColor(selectedDiv) {

  /* VARS TO SECOND COLOR MIXTURE */
  var wSec = $(".second_color_shape"+(selectedDiv)).width();
  var hSec = $(".second_color_shape"+(selectedDiv)).height();
  var margin = {top: 20, right: 150, bottom: 20, left: 20};

  var secShape = d3.select(".second_color_shape"+(selectedDiv))
                    .append("svg")
                    .attr("width", wSec)
                    .attr("height", hSec);

  secShape.append("circle")
          .attr("r", wSec*0.3)
          .attr("cx", wSec*0.45 + margin.left)
          .attr("cy", hSec*0.5 + margin.top)
          .attr("fill", "white")
          .attr("stroke-width", 2.5)
          .style("stroke", "black");
}

/* FUNCTION TO DRAW FIRST SLIDER AND HANDLE ITS MOVEMENT */
function drawFirstSlider(selectedDiv) {

  /* VARS TO SET SVG CANVAS*/
  var margin = {top: 20, right: 150, bottom: 20, left: 5};
  var wSlid = $(".slider_one"+(selectedDiv)).width();
  var hSlid = $(".slider_one"+(selectedDiv)).height();

  var scaleX = d3.scale.linear()
                       .domain([0, 360])
                       .range([0, wSlid])
                       .clamp(true);

  var brush = d3.svg.brush()
                     .x(scaleX)
                     .extent([0, 0])
                     .on("brush", brushed);

  var sliderBar = d3.select(".slider_one"+(selectedDiv)).append("svg")
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
                 .tickFormat(function(d) { return "|"; })
                 .ticks(0)    //SET NUMBER OF TICKS
                 .tickSize(0)
                 .tickPadding(5))
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
        .call(brush.extent([0, 0]))
        .call(brush.event);

  function brushed() {
      var value = brush.extent()[0];
      var colorShape = ".first_color_shape"+(selectedDiv)+" svg";
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

/* FUNCTION TO DRAW SECOND SLIDER AND HANDLE ITS MOVEMENT */
function drawSecondSlider(selectedDiv) {

  /* VARS TO SET SVG CANVAS*/
  var margin = {top: 20, right: 150, bottom: 20, left: 5};
  var wSlid = $(".slider_two"+(selectedDiv)).width();
  var hSlid = $(".slider_two"+(selectedDiv)).height();

  var scaleX = d3.scale.linear()
                       .domain([0, 360])
                       .range([0, wSlid])
                       .clamp(true);

  var brush = d3.svg.brush()
                     .x(scaleX)
                     .extent([0, 0])
                     .on("brush", brushed);

  var sliderBar = d3.select(".slider_two"+(selectedDiv)).append("svg")
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
                 .tickFormat(function(d) { return "|"; })
                 .ticks(0)
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
        .call(brush.extent([0, 0]))
        .call(brush.event);

  function brushed() {
      var value = brush.extent()[0];
      var colorShape = ".second_color_shape"+(selectedDiv)+" svg";
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

function drawObjectiveSlider(selectedDiv) {

  /* VARS TO SET SVG CANVAS*/
  var margin = {top: 20, right: 150, bottom: 20, left: 5};
  var wSlid = $(".slider_objective"+(selectedDiv)).width();
  var hSlid = $(".slider_objective"+(selectedDiv)).height();

  var scaleX = d3.scale.linear()
                       .domain([0, 360])
                       .range([0, wSlid])
                       .clamp(true);

  var brush = d3.svg.brush()
                     .x(scaleX)
                     .extent([0, 0])
                     .on("brush", brushed);

  var sliderBar = d3.select(".slider_objective"+(selectedDiv)).append("svg")
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
                 .tickFormat(function(d) { return "|"; })
                 .ticks(0)
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
        .call(brush.extent([0, 0]))
        .call(brush.event);

  function brushed() {
      var value = brush.extent()[0];
      var colorShape = ".obj_color_shape"+(selectedDiv)+" svg";
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

!(function (d3) {

  /* SVG CANVAS DIMENSION */
  /*var margin = {top: h*0.05, right: w*0.025, bottom: h*0.05, left: w*0.06},
  width = w*0.45 - margin.left - margin.right,
  height = h*0.45 - margin.top - margin.bottom;*/

  var selectdiv = new Date().getTime() % 2;
  $("#mixture"+(selectdiv)).css("display", "block");

  /* SHAPES */
  drawObjective(selectdiv);
  drawFirstColor(selectdiv);
  drawSecColor(selectdiv);

  /* SLIDERS */
  drawFirstSlider(selectdiv);
  drawSecondSlider(selectdiv);
  drawObjectiveSlider(selectdiv);

})(d3);
