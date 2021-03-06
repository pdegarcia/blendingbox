<?php

  session_start();

  $user="ist167051";		// -> substituir pelo nome de utilizador
  $host="db.tecnico.ulisboa.pt";	// o Postgres esta disponivel nesta maquina
  $port=5432;				// por omissao, o Postgres responde nesta porta
  $password="ogqk6522";	// -> substituir pela password dada pelo psql_reset
  $dbname = $user;		// a BD tem nome identico ao utilizador

  $connection = pg_connect("host=$host port=$port user=$user password=$password dbname=$dbname") or die(pg_last_error());

  //echo("<p>Connected to Postgres on $host as user $user on database $dbname.</p>");
  $auxTime = date("H:i:s", time()); //Current time
  $auxTime = $auxTime - $_SESSION["timeOriginal"]; //Sub ao original

  $inputPlate1 = pg_escape_string($_POST['inputPlateOne']);
  $inputPlate2 = pg_escape_string($_POST['inputPlateTwo']);
  $inputPlate3 = pg_escape_string($_POST['inputPlateThree']);
  $inputPlate4 = pg_escape_string($_POST['inputPlateFour']);
  $inputPlate5 = pg_escape_string($_POST['inputPlateFive']);
  $inputPlate6 = pg_escape_string($_POST['inputPlateSix']);

  $query = "insert into ishihara values
  ('" . $_SESSION["id"] . "',
   '" . $inputPlate1 . "', '" . $inputPlate2 . "', '" . $inputPlate3 . "',
   '" . $inputPlate4 . "', '" . $inputPlate5 . "', '" . $inputPlate6 . "')";

  $update = "update profiling_info set time_spent = '" . $auxTime . "' where id = '" . $_SESSION["id"] . "'";

   if($_SESSION["addedIshihara"] === FALSE) {
     $result = pg_query($query) or die('ERROR with query: ' . pg_last_error());
     $resultUpdate = pg_query($update) or die('ERROR with query: ' . pg_last_error());
     $result = pg_free_result($result) or die('ERROR: ' . pg_last_error());
     $resultUpdate = pg_free_result($resultUpdate) or die('ERROR: ' . pg_last_error());
     //echo("<p>Query result freed.</p>");
   }

   pg_close($connection);

   $_SESSION["addedIshihara"] = TRUE;

   //echo("<p>Connection closed.</p>");

   if($_SESSION["inPerson"] === 1){
     header('Location:../html/coreLab.html');
   } else {
     header('Location:../html/core.html');
   } 
?>
