function alertTitle() {
  switch (document.documentElement.lang) {
    case 'en':
      var r = confirm("Returning to homepage will cause you the lost of all information. Are you sure you want to proceed?");
      if (r === true) {
        location.href = "../../indexEN.html";
      }
      break;
    case 'pt':
      var rpt = confirm("Voltar atrás fará com que perca toda a informação. Tem a certeza?");
      if (rpt === true) {
        location.href = "../index.html";
      }
      break;
  }

}
