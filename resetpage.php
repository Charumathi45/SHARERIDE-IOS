<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);
header('Content-Type: application/json');

include('config.php');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode([
        "status" => false,
        "message" => "Invalid request method. Use POST."
    ]);
    exit();
}

$required = ['email', 'new_password'];
foreach ($required as $field) {
    if (empty($_POST[$field])) {
        echo json_encode([
            "status" => false,
            "message" => "Missing field: $field"
        ]);
        exit();
    }
}

$email = $conn->real_escape_string($_POST['email']);
$newPassword = $conn->real_escape_string($_POST['new_password']); // You can hash it later

// Check if the email exists
$check_sql = "SELECT id FROM user_signup WHERE email = '$email'";
$check_result = $conn->query($check_sql);

if (!$check_result || $check_result->num_rows === 0) {
    echo json_encode([
        "status" => false,
        "message" => "Email not found."
    ]);
    exit();
}

// Update the password
$update_sql = "UPDATE user_signup SET password = '$newPassword' WHERE email = '$email'";
if ($conn->query($update_sql)) {
    echo json_encode([
        "status" => true,
        "message" => "Password reset successfully."
    ]);
} else {
    echo json_encode([
        "status" => false,
        "message" => "Password reset failed: " . $conn->error
    ]);
}
?>
