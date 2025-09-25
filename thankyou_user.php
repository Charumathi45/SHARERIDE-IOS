<?php
header('Content-Type: application/json');
include('config.php'); // <-- Your DB connection file

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Read POST parameter
    $user_id = $_POST['user_id'] ?? '';

    if (empty($user_id)) {
        echo json_encode([
            "success" => false,
            "message" => "User ID is required"
        ]);
        exit;
    }

    // Prepare delete query
    $stmt = $conn->prepare("DELETE FROM users WHERE id = ?");
    $stmt->bind_param("i", $user_id);

    if ($stmt->execute()) {
        if ($stmt->affected_rows > 0) {
            echo json_encode([
                "success" => true,
                "message" => "User deleted successfully."
            ]);
        } else {
            echo json_encode([
                "success" => false,
                "message" => "No user found with this ID."
            ]);
        }
    } else {
        echo json_encode([
            "success" => false,
            "message" => "Failed to delete user."
        ]);
    }

    $stmt->close();
    $conn->close();

} else {
    echo json_encode([
        "success" => false,
        "message" => "Invalid request method. Use POST."
    ]);
}
?>
