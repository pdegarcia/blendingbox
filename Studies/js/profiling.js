$('#profiling-submit').prop('disabled', true);

function updateFormEnabled() {
    if (verifyAllFields()) {
        $('#profiling-submit').prop('disabled', false);
    } else {
        $('#profiling-submit').prop('disabled', true);
    }
}

function verifyAllFields() {
    if ($('#age').val() !== "undefined" &&
        $('#gridRadios').val() !== "undefined" &&
        $('#academic').val() !== '' &&
        $('#nacional').val() !== '' &&
        $('#countryResidence').val() !== '') {
        return true;
    } else {
        return false;
    }
}
