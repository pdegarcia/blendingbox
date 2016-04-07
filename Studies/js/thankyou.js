var phpURL;
var quote1;
var quote2;

switch (document.documentElement.lang) {
  case 'pt':
    phpURL = "../php/addMessageForm.php";
    quote1 = "Obrigado!";
    quote2 = "Entraremos em contacto brevemente.";
    break;
  case 'en':
    phpURL = "../../php/addMessageForm.php";
    quote1 = "Thank you!";
    quote2 = "We will be in touch soon.";
    break;
}

$(function() {
  $('.error').hide();
  $('#form-submit').click(function() {
    $('.error').hide();
    var name = $("input#name").val();
    if (name === '') {
      $("label#name_error").show();
      $("input#name").focus();
      return false;
    }
    var email = $("input#email").val();
    if (email === '') {
      $("label#email_error").show();
      $("input#email").focus();
      return false;
    }
    var message = $("input#message").val();
    if (message === '') {
      $("label#message_error").show();
      $("input#message").focus();
      return false;
    }

    var values = {
      name: $("input#name").val(),
      email: $("input#email").val(),
      message: $("textarea#message").val(),
      results: $("input#results").val()
    };
    $.ajax({
      type: "POST",
      url: phpURL,
      data: values,
      success: function() {
        $('#contact_form').html("<div id='message'></div>");
        $('#message').html("<h3>" + quote1 + "</h3>")
          .append("<p>" + quote2 + "</p>")
          .hide()
          .fadeIn(1500, function() {
            switch (document.documentElement.lang) {
              case 'pt':
                $('#message').append("<img id='checkmark' src='../images/check.png' />");
                break;
              case 'en':
                $('#message').append("<img id='checkmark' src='../../images/check.png' />");
                break;
            }
          });
      },
      error: function(jqXHR, textStatus, errorThrown) {
        console.log(textStatus, errorThrown);
      }
    });
    return false;
  });
});
