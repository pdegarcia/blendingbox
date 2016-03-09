$("#profilingForm").submit(function (event) {
      event.preventDefault();
      submitForm();
});

/*var $academic = $('#academic');

$.getJSON("../data/populate.json", function(data) {

  console.log("oi");

  var key = "grau";
  var vals = data.grau.split(",");

  $academic.html('');

  console.log(vals);

  $.each(vals, function(key, val) {
    console.log(key + "," + val);
    $academic.append("<option>" + val.name + "</option>");
  });

});*/
