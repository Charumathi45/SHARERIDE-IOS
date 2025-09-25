<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

header("Content-Type: application/json");
include_once 'config.php'; // PDO connection ($conn)

$email = isset($_POST['email']) ? trim($_POST['email']) : '';
$password = isset($_POST['password']) ? $_POST['password'] : '';

if (!$email || !$password) {
    http_response_code(400);
    echo json_encode([
        "status" => false,
        "error" => "Email and new password are required"
    ]);
    exit();
}

try {
    // Check if email exists
    $stmt = $conn->prepare("SELECT id FROM users WHERE email = :email");
    $stmt->bindValue(':email', $email, PDO::PARAM_STR);
    $stmt->execute();

    if ($stmt->rowCount() === 0) {
        http_response_code(404);
        echo json_encode([
            "status" => false,
            "error" => "Email not found"
        ]);
        exit();
    }

    // Update password (plain text - for learning only)
    $update = $conn->prepare("UPDATE users SET password = :password WHERE email = :email");
    $update->bindValue(':password', $password, PDO::PARAM_STR);
    $update->bindValue(':email', $email, PDO::PARAM_STR);

    if ($update->execute()) {
        echo json_encode([
            "status" => true,
            "message" => "Password reset successfully"
        ]);
    } else {
        http_response_code(500);
        echo json_encode([
            "status" => false,
            "error" => "Failed to reset password"
        ]);
    }
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        "status" => false,
        "error" => "Database error: " . $e->getMessage()
    ]);
}
