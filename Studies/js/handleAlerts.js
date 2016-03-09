function alertAbout() {
    var r = confirm("Voltar atrás fará com que perca toda a informação. Tem a certeza?");
    if (r === true) {
        location.href = "../index.html#about";
    }
}

function alertTitle() {
    var r = confirm("Voltar atrás fará com que perca toda a informação. Tem a certeza?");
    if (r === true) {
        location.href = "../index.html";
    }
}
