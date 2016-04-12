$('#ishihara-submit').prop('disabled', true);

function updateFormEnabled() {
    if (verifyAllFields()) {
        $('#ishihara-submit').prop('disabled', false);
    } else {
        $('#ishihara-submit').prop('disabled', true);
    }
}

function verifyAllFields() {
    if ($('#inputPlateOne').val() !== '' &&
        $('#inputPlateTwo').val() !== '' &&
        $('#inputPlateThree').val() !== '' &&
        $('#inputPlateFour').val() !== '' &&
        $('#inputPlateFive').val() !== '' &&
        $('#inputPlateSix').val() !== '') {
        return true;
    } else {
        return false;
    }
}

$('#inputPlateOne').change(updateFormEnabled);
$('#inputPlateTwo').change(updateFormEnabled);
$('#inputPlateThree').change(updateFormEnabled);
$('#inputPlateFour').change(updateFormEnabled);
$('#inputPlateFive').change(updateFormEnabled);
$('#inputPlateSix').change(updateFormEnabled);
