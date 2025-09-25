<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);
header('Content-Type: application/json');

include('config.php'); // Make sure $conn is set here

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode([
        "success" => false,
        "message" => "Invalid request method. Use POST."
    ]);
    exit();
}

$required = ['name', 'email', 'password'];
foreach ($required as $field) {
    if (empty($_POST[$field])) {
        echo json_encode([
            "success" => false,
            "message" => "Missing field: $field"
        ]);
        exit();
    }
}

$name = $conn->real_escape_string($_POST['name']);
$email = $conn->real_escape_string($_POST['email']);
$password = $conn->real_escape_string($_POST['password']); // You can hash it later

$check_sql = "SELECT id FROM user_signup WHERE email = '$email'";
$check_result = $conn->query($check_sql);
if ($check_result && $check_result->num_rows > 0) {
    echo json_encode([
        "success" => false,
        "message" => "Email already exists."
    ]);
    exit();
}

$insert_sql = "INSERT INTO user_signup (name, email, password) VALUES ('$name', '$email', '$password')";
if ($conn->query($insert_sql)) {
    echo json_encode([
        "success" => true,
        "message" => "User registered successfully."
    ]);
} else {
    echo json_encode([
        "success" => false,
        "message" => "Registration failed: " . $conn->error
    ]);
}
?>
