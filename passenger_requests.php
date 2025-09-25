<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

include 'config.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $driver_id = $_POST['driver_id'] ?? null;
    $seats_requested = $_POST['seats_requested'] ?? null;

    if (!$driver_id || !$seats_requested) {
        echo json_encode(["success" => false, "message" => "Missing required fields"]);
        exit;
    }

    $sql = "INSERT INTO passenger_requests (driver_id, seats_requested) VALUES (?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ii", $driver_id, $seats_requested);

    if ($stmt->execute()) {
        echo json_encode(["success" => true, "message" => "Request submitted"]);
    } else {
        echo json_encode(["success" => false, "message" => "Failed to submit request"]);
    }

    $stmt->close();
    $conn->close();
} else {
    echo json_encode(["success" => false, "message" => "Invalid request method"]);
}
?>
