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
$name  = $_POST['name']  ?? null;
$email = $_POST['email'] ?? null;

if (!$name && !$email) {
    echo json_encode(["success" => false, "message" => "Please provide name or email"]);
    exit();
}

// Build query dynamically
if ($name) {
    $sql = "SELECT * FROM driver_registration WHERE full_name = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $name);
} elseif ($email) {
    $sql = "SELECT * FROM driver_registration WHERE email = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $email);
}

if (!$stmt) {
    echo json_encode(["success" => false, "message" => "Prepare failed: " . $conn->error]);
    exit();
}

$stmt->execute();
$result = $stmt->get_result();

if ($result && $result->num_rows > 0) {
    echo json_encode([
        "success" => true,
        "message" => "Driver found."
    ]);
} else {
    echo json_encode([
        "success" => false,
        "message" => "Driver not found."
    ]);
}

$stmt->close();
$conn->close();
?>
