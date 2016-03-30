/*(function() {
  console.log("Oi");
  $("#profilingForm > input").keyup(function() {
      var empty = false;
      console.log("oi 2");
      $('profilingForm > input').each(function() {
        if($(this).val() === '') {
          empty = true;
        }
      });

      if(empty) {
        $('#profiling-submit').attr('disabled', 'disabled');
      } else {
        $('#profiling-submit').removeAttr('disabled');
      }
  });
})()*/
