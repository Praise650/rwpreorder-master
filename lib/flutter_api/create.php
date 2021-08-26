<?php
header('Content-Type: application/json');
include ("./db.php");

// Read the input stream
$body = file_get_contents("php://input");
 
// Decode the JSON object
$object = json_decode($body, true)

$name = (int)$_POST['name'];
$gender = (int)$_POST['gender'];
$lastname = (int)$_POST['lastname'];

$stmt = $db->prepare("INSERT INTO church_members (name, gender,lastname,) VALUES ('$name','$gender','$lastname')");
$result = $stmt->execute([$name,$gender,$lastname]);

echo json_encode([
'success' => $result
]);