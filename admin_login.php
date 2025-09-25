<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);
header('Content-Type: application/json');

include('config.php'); // This should define $conn (MySQLi)

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode([
        "success" => false,
        "message" => "Invalid request method. Use POST.",
        "data" => []
    ]);
    exit();
}

// Required fields
$required = ['admin_id', 'password'];
foreach ($required as $field) {
    if (empty($_POST[$field])) {
        echo json_encode([
            "success" => false,
            "message" => "Missing field: $field",
            "data" => []
        ]);
        exit();
    }
}

$admin_id = $conn->real_escape_string($_POST['admin_id']);
$password = $conn->real_escape_string($_POST['password']);

// Fetch admin by admin_id
$login_stmt = $conn->prepare("SELECT id, admin_id, email, password FROM admin_signup WHERE admin_id = ?");
$login_stmt->bind_param("s", $admin_id);
$login_stmt->execute();
$result = $login_stmt->get_result();

if ($result && $result->num_rows > 0) {
    $admin = $result->fetch_assoc();

    // Password match check (plain text version)
    if ($password === $admin['password']) {
        echo json_encode([
            "success" => true,
            "message" => "Login successful",
            "data" => [
                "id" => $admin['id'],
                "admin_id" => $admin['admin_id'],
                "email" => $admin['email']
            ]
        ]);
    } else {
        echo json_encode([
            "success" => false,
            "message" => "Incorrect password",
            "data" => []
        ]);
    }
} else {
    echo json_encode([
        "success" => false,
        "message" => "Admin ID not found",
        "data" => []
    ]);
}

$login_stmt->close();
$conn->close();
?>
