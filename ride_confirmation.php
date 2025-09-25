<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
include 'config.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $driver_id = $_POST['driver_id'] ?? null;
    $passenger_name = $_POST['passenger_name'] ?? null;
    $seats_confirmed = $_POST['seats_confirmed'] ?? null;
    $fare = $_POST['fare'] ?? null;

    if (!$driver_id || !$passenger_name || !$seats_confirmed || !$fare) {
        echo json_encode(["success" => false, "message" => "All fields are required."]);
        exit;
    }

    $sql = "INSERT INTO ride_confirmation (driver_id, passenger_name, seats_confirmed, fare) 
            VALUES (?, ?, ?, ?)";

    $stmt = $conn->prepare($sql);
    $stmt->bind_param("isid", $driver_id, $passenger_name, $seats_confirmed, $fare);

    if ($stmt->execute()) {
        echo json_encode(["success" => true, "message" => "Ride confirmation saved successfully."]);
    } else {
        echo json_encode(["success" => false, "message" => "Database error: " . $stmt->error]);
    }

    $stmt->close();
    $conn->close();
} else {
    echo json_encode(["success" => false, "message" => "Invalid request method."]);
}
?>
