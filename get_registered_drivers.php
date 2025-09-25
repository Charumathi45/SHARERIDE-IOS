<?php
header('Content-Type: application/json');

// Database config
$host = "localhost";
$db = "shareride";
$user = "root";
$pass = "";

// Connect
$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
    echo json_encode(["success" => false, "message" => "Database connection failed"]);
    exit();
}

// Fetch all registered drivers
$sql = "SELECT id, full_name, mobile_number, license_number, rc_number, vehicle_type, car_model FROM driver_registration";
$result = $conn->query($sql);

$drivers = [];

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $drivers[] = $row;
    }
    echo json_encode(["success" => true, "drivers" => $drivers]);
} else {
    echo json_encode(["success" => false, "message" => "No drivers found"]);
}

$conn->close();
?>
