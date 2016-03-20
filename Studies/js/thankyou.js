$("#contactForm").validator().on("submit", function (event) {
    if (event.isDefaultPrevented()) {
        // handle the invalid form...
    } else {
        // everything looks good!
        event.preventDefault();
        submitForm();
    }
});

function submitForm() {
  var name = $("#name").val(); //Form content
  var email = $("#email").val();
  var message = $("#message").val();

  $.ajax({
    type: "POST",
    url: "php/contactForm-process.php",
    data: "name=" + name + "&email=" + email + "&message=" + message,
    success: function(text) {
      if (text === "success") {
        formSuccess();
      }
    }
  });
}

function formSuccess() {
  $("#msgSubmit").removeClass("hidden");
}
