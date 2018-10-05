<?php
	
	$cn =new mysqli("localhost","root","","sunny");
	$data = file_get_contents('php://input');

	$dt = json_decode($data);
	$emp_name = $dt -> emp_name;
	define('UPLOAD_DIR','image/');
	$img = $dt -> emp_img;

	$img = str_replace('data:image/png;base64', '', $img);
	$data = base64_decode($img);
	$file = UPLOAD_DIR.uniqid().'.png';
	$success = file_put_contents($file, $data);

	$q = "insert into emp(emp_name,emp_img) values ('$emp_name','$file')";

	$cn -> query($q);

	echo "Successfully Uploaded";

?>