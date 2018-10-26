<?php
	$cn =new mysqli("localhost","root","","sutex");
	$name = $_REQUEST["name"];
	$phno = $_REQUEST["phno"];
	$email = $_REQUEST["email"];
	$pass = $_REQUEST["pass"];

	$query = "insert into reg(name,phno,email,pass)values('$name','$phno','$email','$pass')";
	$cn->query($query);
	echo "Succesfully inserted";
?>