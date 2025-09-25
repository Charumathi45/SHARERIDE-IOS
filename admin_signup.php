<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);
header('Content-Type: application/json');

include('config.php'); // This should define $conn (MySQLi)

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode([
        "success" => false,
        "message" => "Invalid request method. Use POST."
    ]);
    exit();
}

// Required fields
$required = ['admin_id', 'email', 'password', 'confirm_password'];
foreach ($required as $field) {
    if (empty($_POST[$field])) {
        echo json_encode([
            "success" => false,
            "message" => "Missing field: $field"
        ]);
        exit();
    }
}

$admin_id = $conn->real_escape_string($_POST['admin_id']);
$email = $conn->real_escape_string($_POST['email']);
$password = $conn->real_escape_string($_POST['password']);
$confirm_password = $conn->real_escape_string($_POST['confirm_password']);

// Check if passwords match
if ($password !== $confirm_password) {
    echo json_encode([
        "success" => false,
        "message" => "Passwords do not match."
    ]);
    exit();
}

// Check if admin already exists
$check_stmt = $conn->prepare("SELECT id FROM admin_signup WHERE admin_id = ? OR email = ?");
$check_stmt->bind_param("ss", $admin_id, $email);
$check_stmt->execute();
$result = $check_stmt->get_result();

if ($result && $result->num_rows > 0) {
    echo json_encode([
        "success" => false,
        "message" => "Admin ID or Email already exists."
    ]);
    $check_stmt->close();
    exit();
}
$check_stmt->close();

// Insert admin (no hashing here — for testing only)
$insert_stmt = $conn->prepare("INSERT INTO admin_signup (admin_id, email, password, confirm_password) VALUES (?, ?, ?, ?)");
$insert_stmt->bind_param("ssss", $admin_id, $email, $password, $confirm_password);

if ($insert_stmt->execute()) {
    echo json_encode([
        "success" => true,
        "message" => "Admin registered successfully."
    ]);
} else {
    echo json_encode([
        "success" => false,
        "message" => "Registration failed: " . $conn->error
    ]);
}

$insert_stmt->close();
$conn->close();
?>
