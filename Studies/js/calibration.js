/*$("#calibrationForm").submit(function (event) {
      event.preventDefault();
      submitForm();
});*/

$("#resolutionField").append(window.screen.width + "x" + window.screen.height);
$("#availableResolutionField").append("<b>" + window.screen.availWidth + "x" + window.screen.availHeight + "</b>");
$("#colorDepthField").append(window.screen.colorDepth);
