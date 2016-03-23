<?php

  //session_start();

  $user="ist167051";		// -> substituir pelo nome de utilizador
  $host="db.tecnico.ulisboa.pt";	// o Postgres esta disponivel nesta maquina
  $port=5432;				// por omissao, o Postgres responde nesta porta
  $password="ogqk6522";	// -> substituir pela password dada pelo psql_reset
  $dbname = $user;		// a BD tem nome identico ao utilizador

  $connection = pg_connect("host=$host port=$port user=$user password=$password dbname=$dbname") or die(pg_last_error());

  echo("<p>Connected to Postgres on $host as user $user on database $dbname.</p>");

  $_SESSION["id"] = uniqid();
  $age = pg_escape_string($_POST['inputAge']);
  $gender = pg_escape_string($_POST['gridRadios']);
  $academic = pg_escape_string($_POST['academic']);
  $nationality = pg_escape_string($_POST['nacional']);
  $cResidence = pg_escape_string($_POST['countryResidence']);

  $query = "insert into profiling_info values ('" . $_SESSION["id"] . "', '" . $age . "', '" . $academic . "', '" . $nationality . "', '" . $cResidence . "', '" . $gender . "')";

  $result = pg_query($query) or die('ERROR with query: ' . pg_last_error());

  $result = pg_free_result($result) or die('ERROR: ' . pg_last_error());

  echo("<p>Query result freed.</p>");

  pg_close($connection);

  echo("<p>Connection closed.</p>");

  header('Location:../html/en/calibration.html');
?>
