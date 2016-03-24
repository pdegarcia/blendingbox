<?php

  session_start();

  $user="ist167051";		// -> substituir pelo nome de utilizador
  $host="db.tecnico.ulisboa.pt";	// o Postgres esta disponivel nesta maquina
  $port=5432;				// por omissao, o Postgres responde nesta porta
  $password="ogqk6522";	// -> substituir pela password dada pelo psql_reset
  $dbname = $user;		// a BD tem nome identico ao utilizador

  $connection = pg_connect("host=$host port=$port user=$user password=$password dbname=$dbname") or die(pg_last_error());

  echo("<p>Connected to Postgres on $host as user $user on database $dbname.</p>");

  $inputBlackSquares1 = pg_escape_string($_POST['inputBlackSquare1']);
  $inputBlackSquares2 = pg_escape_string($_POST['inputBlackSquare2']);
  $inputBlackSquares3 = pg_escape_string($_POST['inputBlackSquare3']);
  $inputBlackSquares4 = pg_escape_string($_POST['inputBlackSquare4']);
  $inputBlackSquares5 = pg_escape_string($_POST['inputBlackSquare5']);
  $inputBlackSquares6 = pg_escape_string($_POST['inputBlackSquare6']);
  $inputBlackSquares7 = pg_escape_string($_POST['inputBlackSquare7']);
  $inputBlackSquares8 = pg_escape_string($_POST['inputBlackSquare8']);
  $inputBlackSquares9 = pg_escape_string($_POST['inputBlackSquare9']);
  $inputBlackSquares10 = pg_escape_string($_POST['inputBlackSquare10']);

  $inputWhiteSquares1 = pg_escape_string($_POST['inputWhiteSquare1']);
  $inputWhiteSquares2 = pg_escape_string($_POST['inputWhiteSquare2']);
  $inputWhiteSquares3 = pg_escape_string($_POST['inputWhiteSquare3']);
  $inputWhiteSquares4 = pg_escape_string($_POST['inputWhiteSquare4']);
  $inputWhiteSquares5 = pg_escape_string($_POST['inputWhiteSquare5']);
  $inputWhiteSquares6 = pg_escape_string($_POST['inputWhiteSquare6']);
  $inputWhiteSquares7 = pg_escape_string($_POST['inputWhiteSquare7']);
  $inputWhiteSquares8 = pg_escape_string($_POST['inputWhiteSquare8']);
  $inputWhiteSquares9 = pg_escape_string($_POST['inputWhiteSquare9']);
  $inputWhiteSquares10 = pg_escape_string($_POST['inputWhiteSquare10']);

  $dimensions = pg_escape_string($_POST['resolutionField']);
  $availableDim = pg_escape_string($_POST['availableResolutionField']);
  $colorDepth = pg_escape_string($_POST['colorDepthField']);

  $query = "insert into calibration_info values
  ('" . $_SESSION["id"] . "',
   '" . $inputBlackSquares1 . "', '" . $inputBlackSquares2 . "', '" . $inputBlackSquares3 . "',
   '" . $inputBlackSquares4 . "', '" . $inputBlackSquares5 . "', '" . $inputBlackSquares6 . "',
   '" . $inputBlackSquares7 . "', '" . $inputBlackSquares8 . "', '" . $inputBlackSquares9 . "',
   '" . $inputBlackSquares10 . "',
   '" . $inputWhiteSquares1 . "', '" . $inputWhiteSquares2 . "', '" . $inputWhiteSquares3 . "',
   '" . $inputWhiteSquares4 . "', '" . $inputWhiteSquares5 . "', '" . $inputWhiteSquares6 . "',
   '" . $inputWhiteSquares7 . "', '" . $inputWhiteSquares8 . "', '" . $inputWhiteSquares9 . "',
   '" . $inputWhiteSquares10 . "',
   '" . $dimensions . "', '" . $availableDim . "', '" . $colorDepth . "')";

   $result = pg_query($query) or die('ERROR with query: ' . pg_last_error());

   $result = pg_free_result($result) or die('ERROR: ' . pg_last_error());

   echo("<p>Query result freed.</p>");

   pg_close($connection);

   echo("<p>Connection closed.</p>");

   header('Location:../html/en/ishihara.html');

?>
