<?php

  session_start();

  $user="ist167051";		// -> substituir pelo nome de utilizador
  $host="db.tecnico.ulisboa.pt";	// o Postgres esta disponivel nesta maquina
  $port=5432;				// por omissao, o Postgres responde nesta porta
  $password="ogqk6522";	// -> substituir pela password dada pelo psql_reset
  $dbname = $user;		// a BD tem nome identico ao utilizador

  $connection = pg_connect("host=$host port=$port user=$user password=$password dbname=$dbname") or die(pg_last_error());

  //echo("<p>Connected to Postgres on $host as user $user on database $dbname.</p>");

  $typeOfQuestion = pg_escape_string($_POST['typeOfQuestion']);
  $numberOfQuestion = pg_escape_string($_POST['idQuestion']);
  $firstColor = pg_escape_string($_POST['firstColor']);
  $secColor = pg_escape_string($_POST['secColor']);
  $thirdColor = pg_escape_string($_POST['thirdColor']);
  $numClicks = pg_escape_string($_POST['numClicks']);
  $pageTime = pg_escape_string($_POST['pageTime']);
  $rating = pg_escape_string($_POST['stars']);
  $resets = pg_escape_string($_POST['numResets']);

  $_SESSION["countAnswers"]++;

  $query = "insert into results values
  ('" . $_SESSION["id"] . "',
   '" . $typeOfQuestion . "', '" . $firstColor . "', '" . $secColor . "',
   '" . $thirdColor . "', '" . $numClicks . "', '" . $pageTime . "',
   '" . $rating . "', '" . $resets . "', '" . $numberOfQuestion . "')";

   $update = "update profiling_info set num_answers = '" . $_SESSION["countAnswers"] . "' where id = '" . $_SESSION["id"] . "'";

   $result = pg_query($query) or die('ERROR with query: ' . pg_last_error());
   $resultUpdate = pg_query($update) or die('ERROR with query: ' . pg_last_error());

   $result = pg_free_result($result) or die('ERROR: ' . pg_last_error());
   $resultUpdate = pg_free_result($resultUpdate) or die('ERROR: ' . pg_last_error());


   //echo("<p>Query result freed.</p>");

   pg_close($connection);

   //echo("<p>Connection closed.</p>");

?>
