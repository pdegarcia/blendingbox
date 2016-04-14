<?php

  session_start();

  $user="ist167051";		// -> substituir pelo nome de utilizador
  $host="db.tecnico.ulisboa.pt";	// o Postgres esta disponivel nesta maquina
  $port=5432;				// por omissao, o Postgres responde nesta porta
  $password="ogqk6522";	// -> substituir pela password dada pelo psql_reset
  $dbname = $user;		// a BD tem nome identico ao utilizador

  $connection = pg_connect("host=$host port=$port user=$user password=$password dbname=$dbname") or die(pg_last_error());

  //echo("<p>Connected to Postgres on $host as user $user on database $dbname.</p>");
  $auxTime = date("i:s", time()); //Current time
  $auxTime = $auxTime - $_SESSION["timeOriginal"]; //Sub ao original

  $numBlackSquare = pg_escape_string($_POST['inputBlackSquare1']);
  $wordBlackSquare = pg_escape_string($_POST['inputBlackSquare2']);

  $numWhiteSquare = pg_escape_string($_POST['inputWhiteSquare1']);
  $wordWhiteSquare = pg_escape_string($_POST['inputWhiteSquare2']);

  $dimensions = pg_escape_string($_POST['resolutionField']);
  $availableDim = pg_escape_string($_POST['availableResolutionField']);
  $colorDepth = pg_escape_string($_POST['colorDepthField']);

  $query = "insert into calibration_info values
  ('" . $_SESSION["id"] . "',
   '" . $numBlackSquare . "', '" . $wordBlackSquare . "', '" . $numWhiteSquare . "',
   '" . $wordWhiteSquare . "', '" . $dimensions . "', '" . $availableDim . "', '" . $colorDepth . "')";

  $update = "update profiling_info set time_spent = '" . $auxTime . "' where id = '" . $_SESSION["id"] . "'";

   if ($_SESSION["addedCalibration"] === FALSE) { //IF YES - DO QUERY . IF ALREADY ADDED - LEAVE.
     $result = pg_query($query) or die('ERROR with query: ' . pg_last_error());
     $resultUpdate = pg_query($update) or die('ERROR with query: ' . pg_last_error());
     $result = pg_free_result($result) or die('ERROR: ' . pg_last_error());
     $resultUpdate = pg_free_result($resultUpdate) or die('ERROR: ' . pg_last_error());
     //echo("<p>Query result freed.</p>");
   }

   pg_close($connection);

   $_SESSION["addedCalibration"] = TRUE;

   //echo("<p>Connection closed.</p>");

   header('Location:../html/en/ishihara.html');
?>
