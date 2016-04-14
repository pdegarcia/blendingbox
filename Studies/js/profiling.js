$('#profiling-submit').prop('disabled', true);

function updateFormEnabled() {
  if (verifyAllFields()) {
    $('#profiling-submit').prop('disabled', false);
  } else {
    $('#profiling-submit').prop('disabled', true);
  }
}

function verifyAllFields() {
  if ($('#age').val() !== '' &&
    $('#gridRadios').val() !== '' &&
    $('#academic').val() !== '' &&
    $('#nacional').val() !== '' &&
    $('#countryResidence').val() !== '' &&
    $('#language').val() !== '') {
    return true;
  } else {
    return false;
  }
}

  switch (document.documentElement.lang) {
    case 'pt':
      jsonPath = "../data/populateCountries.json";
      jsonLangPath = "../data/populateLanguages.json";
      $.getJSON(jsonPath, function(obj) {
        $.each(obj[0].countriesPT, function(key, value) {
          var optionNac = $('<option />').val(value.iso).text(value.name);
          var optionCoun = $('<option />').val(value.iso).text(value.name);
          $("#nacional").append(optionNac);
          $("#countryResidence").append(optionCoun);
        });
      });
      $.getJSON(jsonLangPath, function(obj) {
        $.each(obj[0].languagesPT, function(key, value) {
          var optionLang = $('<option />').val(value.iso).text(value.name);
          $("#language").append(optionLang);
        });
      });
      break;
    case 'en':
      jsonPath = "../../data/populateCountries.json";
      jsonNatPath = "../../data/populateNationalities.json";
      jsonLangPath = "../../data/populateLanguages.json";
      $.getJSON(jsonPath, function(obj) {     //populate Countries
        $.each(obj[0].countriesEN, function(key, value) {
          var optionCoun = $('<option />').val(value.iso).text(value.name);
          $("#countryResidence").append(optionCoun);
        });
      });
      $.getJSON(jsonNatPath, function(obj) {  //populate Nationalities
        $.each(obj[0].nationalitiesEN, function(key, value) {
          var optionNac = $('<option />').val(value.abr).text(value.name);
          $("#nacional").append(optionNac);
        });
      });
      $.getJSON(jsonLangPath, function(obj) { //populate Languages
        $.each(obj[0].languagesEN, function(key, value) {
          var optionLang = $('<option />').val(value.iso).text(value.name);
          $("#language").append(optionLang);
        });
      });
      break;
  }
