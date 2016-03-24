function start() {
  var ref1 = document.getElementById('resolutionField');
  var ref2 = document.getElementById('availableResolutionField');
  var ref3 = document.getElementById('colorDepthField');

  ref1.value = window.screen.width + "x" + window.screen.height;
  ref2.value = window.screen.availWidth + "x" + window.screen.availHeight;
  ref3.value = window.screen.colorDepth;
}

window.onload = start;
