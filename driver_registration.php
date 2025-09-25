<?php
header('Content-Type: application/json');

// Database config
$host = "localhost";
$db = "shareride";
$user = "root";
$pass = "";

// Connect to MySQL
$conn = new mysqli($host, $user, $pass, $db);

// Connection check
if ($conn->connect_error) {
    echo json_encode(["success" => false, "message" => "Database connection failed"]);
    exit();
}

// Collect POST data
$fullName = $_POST['full_name'] ?? '';
$mobile = $_POST['mobile_number'] ?? '';
$licenseNo = $_POST['license_number'] ?? '';
$rcNo = $_POST['rc_number'] ?? '';
$vehicleType = $_POST['vehicle_type'] ?? '';
$carModel = $_POST['car_model'] ?? '';

// Validate required fields
if (empty($fullName) || empty($mobile) || empty($licenseNo) || empty($rcNo) || empty($vehicleType) || empty($carModel)) {
    echo json_encode(["success" => false, "message" => "All fields are required"]);
    exit();
}

// Prepare SQL insert
$stmt = $conn->prepare("INSERT INTO driver_registration (full_name, mobile_number, license_number, rc_number, vehicle_type, car_model) VALUES (?, ?, ?, ?, ?, ?)");

if (!$stmt) {
    echo json_encode(["success" => false, "message" => "Prepare failed: " . $conn->error]);
    exit();
}

$stmt->bind_param("ssssss", $fullName, $mobile, $licenseNo, $rcNo, $vehicleType, $carModel);

// Execute and respond
if ($stmt->execute()) {
    echo json_encode(["success" => true, "message" => "Driver registered successfully."]);
} else {
    echo json_encode(["success" => false, "message" => "Insert failed: " . $stmt->error]);
}

$stmt->close();
$conn->close();
?>
