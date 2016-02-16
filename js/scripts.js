function drawObjective() {

  /* VARS TO OBJECTIVE */
  var wObj = $("#obj_color_shape").width();
  var hObj = $("#obj_color_shape").height();

  var objShape = d3.select("#obj_color_shape")
            .append("svg:svg")
            .attr("width", wObj)
            .attr("height", hObj);

  objShape.append("svg:rect")
          .attr("x", 150)
          .attr("y", 50)
          .attr("width", 250)
          .attr("height", 250)
          .attr("fill", "white")
          .style("stroke", "black");
}

function drawFirstColor() {

  /* VARS TO FIRST COLOR MIXTURE */
  var wFirst = $("#first_color_shape").width();
  var hFirst = $("#first_color_shape").height();

  var fstShape = d3.select("#first_color_shape")
                      .append("svg:svg")
                      .attr("width", wFirst)
                      .attr("height", hFirst);

  fstShape.append("svg:circle")
          .attr("r", 130)
          .attr("cx", 270)
          .attr("cy", 170)
          .attr("fill", "white")
          .style("stroke", "black");
}

function drawSecColor() {

  /* VARS TO SECOND COLOR MIXTURE */
  var wSec = $("#second_color_shape").width();
  var hSec = $("#second_color_shape").height();

  var secShape = d3.select("#second_color_shape")
                    .append("svg:svg")
                    .attr("width", wSec)
                    .attr("height", hSec);

  secShape.append("svg:circle")
          .attr("r", 130)
          .attr("cx", 270)
          .attr("cy", 170)
          .attr("fill", "white")
          .style("stroke", "black");
}

function drawSlider() {

  /* VARS TO SET SVG CANVAS*/
  var margin = {top: 20, right: 50, bottom: 20, left: 50}
  var wSlid = $("#slider_one").width();
  var hSlid = $("#slider_one").height();

  var scaleX = d3.scale.linear()
                       .domain([0, 180])
                       .range([0, wSlid])
                       .clamp(true);

  var slider = d3.select("#slider_one").append("svg")
                 .attr("width", wSlid + margin.left + margin.right)
                 .attr("height", hSlid + margin.top + margin.bottom)
                 .append("g")
                 .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

   slider.append("g")
       .attr("class", "x axis")
       .attr("transform", "translate(0," + hSlid/2 + ")")
       .call(d3.svg.axis()
         .scale(scaleX)
         .orient("bottom")
         .tickFormat(function(d) { return d + "°"; })
         .tickSize(0)
         .tickPadding(12))
     .select(".domain")
     .select(function() { return this.parentNode.appendChild(this.cloneNode(true)); })
       .attr("class", "halo");
}

!(function (d3) {

  /* SVG CANVAS DIMENSION */
  /*var margin = {top: h*0.05, right: w*0.025, bottom: h*0.05, left: w*0.06},
  width = w*0.45 - margin.left - margin.right,
  height = h*0.45 - margin.top - margin.bottom;*/

  drawObjective();
  drawFirstColor();
  drawSecColor();

  drawSlider();


})(d3);
