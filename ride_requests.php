<?php
header('Content-Type: application/json');
ini_set('display_errors', 1);
error_reporting(E_ALL);

// DB credentials
$host = 'localhost';
$db   = 'ShareRide';
$user = 'root';
$pass = '';
$charset = 'utf8mb4';

// PDO setup
$dsn = "mysql:host=$host;dbname=$db;charset=$charset";
$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
];

try {
    $conn = new PDO($dsn, $user, $pass, $options); // ✅ FIXED
} catch (PDOException $e) {
    echo json_encode(["status" => "error", "message" => "DB Connection failed: " . $e->getMessage()]);
    exit;
}

// Get form data
$pickup_location = $_POST['pickup_location'] ?? '';
$dropoff_location = $_POST['dropoff_location'] ?? '';
$raw_date = $_POST['travel_date'] ?? '';
$raw_time = $_POST['travel_time'] ?? '';
$passenger_count = $_POST['passenger_count'] ?? 1;
$driver_note = $_POST['driver_note'] ?? null;

// Convert inputs
$travel_date = date('Y-m-d', strtotime($raw_date));
$raw_time = str_replace('.', ':', $raw_time);
$travel_time = date('H:i:s', strtotime($raw_time));

// Validate inputs
if (!$pickup_location || !$dropoff_location || !$raw_date || !$raw_time) {
    echo json_encode([
        "status" => "error",
        "message" => "Missing required fields",
        "debug" => compact("pickup_location", "dropoff_location", "raw_date", "raw_time")
    ]);
    exit;
}

// Prepare and execute
try {
    $stmt = $conn->prepare("
        INSERT INTO ride_requests (
            pickup_location, dropoff_location, travel_date, travel_time, passenger_count, driver_note
        ) VALUES (
            :pickup_location, :dropoff_location, :travel_date, :travel_time, :passenger_count, :driver_note
        )
    ");

    $success = $stmt->execute([
        ':pickup_location' => $pickup_location,
        ':dropoff_location' => $dropoff_location,
        ':travel_date' => $travel_date,
        ':travel_time' => $travel_time,
        ':passenger_count' => $passenger_count,
        ':driver_note' => $driver_note
    ]);

    if ($success) {
        echo json_encode(["status" => "success", "message" => "Ride request inserted successfully"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Insert failed"]);
    }
} catch (PDOException $e) {
    echo json_encode(["status" => "error", "message" => "Insert failed: " . $e->getMessage()]);
}
?>
