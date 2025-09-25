<?php
header('Content-Type: application/json');
include 'config.php'; // your DB config

$pickup = $_POST['pickup_location'] ?? null;
$dropoff = $_POST['dropoff_location'] ?? null;
$travel_date = $_POST['departure_date'] ?? null;

if (!$pickup || !$dropoff || !$travel_date) {
    echo json_encode(["status" => "error", "message" => "Missing required fields"]);
    exit;
}

$sql = "SELECT * FROM offerrides 
        WHERE pickup_location = ? 
        AND drop_location = ? 
        AND departure_date = ?";

$stmt = $conn->prepare($sql);
$stmt->bind_param("sss", $pickup, $dropoff, $travel_date);
$stmt->execute();

$result = $stmt->get_result();
$rides = [];

while ($row = $result->fetch_assoc()) {
    $rides[] = $row;
}

if (count($rides) > 0) {
    echo json_encode([
        "status" => "success",
        "message" => "Driver rides found",
        "rides" => $rides
    ]);
} else {
    echo json_encode([
        "status" => "success",
        "message" => "No rides available",
        "rides" => []
    ]);
}
