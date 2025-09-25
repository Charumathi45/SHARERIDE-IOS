<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);
header('Content-Type: application/json');

include('config.php'); // Assumes $conn is defined

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode([
        "status" => false,
        "message" => "Invalid request method. Use POST."
    ]);
    exit();
}

// Validate input
if (empty($_POST['Email']) || empty($_POST['Password'])) {
    echo json_encode([
        "status" => false,
        "message" => "Email and Password are required."
    ]);
    exit();
}

// Sanitize input
$email = $conn->real_escape_string($_POST['Email']);
$password = $conn->real_escape_string($_POST['Password']); // NOTE: Password should be hashed in real apps

// Check user credentials
$sql = "SELECT id, name, email FROM user_signup WHERE email = '$email' AND password = '$password'";
$result = $conn->query($sql);

if ($result && $result->num_rows > 0) {
    $user = $result->fetch_assoc();

    echo json_encode([
        "status" => true,
        "message" => "Login successful.",
        "user" => [
            "id" => $user['id'],
            "name" => $user['name'],
            "email" => $user['email']
        ]
    ]);
} else {
    echo json_encode([
        "status" => false,
        "message" => "Invalid Email or Password."
    ]);
}
?>
