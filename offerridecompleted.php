<?php
header("Content-Type: application/json");
include 'config.php'; // Include your DB connection

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $driver_id = $_POST['driver_id'] ?? '';
    $passenger_name = $_POST['passenger_name'] ?? '';
    $from_location = $_POST['from_location'] ?? '';
    $to_location = $_POST['to_location'] ?? '';
    $ride_time = $_POST['ride_time'] ?? '';
    $distance = $_POST['distance'] ?? '';
    $fare = $_POST['fare'] ?? '';
    $rating = isset($_POST['rating']) && $_POST['rating'] !== '' ? $_POST['rating'] : null;
    $feedback = isset($_POST['feedback']) && $_POST['feedback'] !== '' ? $_POST['feedback'] : null;

    if (
        empty($driver_id) || empty($passenger_name) || empty($from_location) ||
        empty($to_location) || empty($ride_time) || empty($distance) || empty($fare)
    ) {
        echo json_encode(["success" => false, "message" => "Missing required fields."]);
        exit;
    }

    $stmt = $conn->prepare("INSERT INTO offerridecompleted 
        (driver_id, passenger_name, from_location, to_location, ride_time, distance, fare, rating, feedback) 
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");

    $stmt->bind_param("ssssssdss", 
        $driver_id,
        $passenger_name,
        $from_location,
        $to_location,
        $ride_time,
        $distance,
        $fare,
        $rating,
        $feedback
    );

    if ($stmt->execute()) {
        echo json_encode([
            "success" => true,
            "message" => "Ride completion data inserted successfully.",
            "data" => [
                "driver_id" => $driver_id,
                "passenger_name" => $passenger_name,
                "from_location" => $from_location,
                "to_location" => $to_location,
                "ride_time" => $ride_time,
                "distance" => $distance,
                "fare" => $fare,
                "rating" => $rating,
                "feedback" => $feedback
            ]
        ]);
    } else {
        echo json_encode(["success" => false, "message" => "Database insert failed."]);
    }

    $stmt->close();
    $conn->close();
} else {
    echo json_encode(["success" => false, "message" => "Invalid request method. Use POST."]);
}
?>
