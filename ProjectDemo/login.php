<?php
	$cn =new mysqli("localhost","root","","sutex");

	$email = $_REQUEST["email"];
	$pass= $_REQUEST["pass"];

	$q = mysqli_query($cn,"select * from reg where email = '$email' and pass = '$pass'");
	if(mysqli_num_rows($q) == 0)
	{
		$row = array();
		print_r(json_encode($row));
	}
	else
	{
		while($row = mysqli_fetch_assoc($q))
		{
			$p[] = $row;
		}
		echo json_encode($p);
	}
?>
