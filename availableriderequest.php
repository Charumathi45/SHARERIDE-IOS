<?php
header('Content-Type: application/json');
ini_set('display_errors', 1);
error_reporting(E_ALL);

// DB config
$host = 'localhost';
$db   = 'ShareRide';
$user = 'root';
$pass = '';
$charset = 'utf8mb4';

// PDO connection setup
$dsn = "mysql:host=$host;dbname=$db;charset=$charset";
$options = [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
];

try {
    $pdo = new PDO($dsn, $user, $pass, $options);
} catch (PDOException $e) {
    echo json_encode(["status" => "error", "message" => "Connection failed: " . $e->getMessage()]);
    exit;
}

// Read POST data
$departure_time = $_POST['departure_time'] ?? null;
$arrival_time = $_POST['arrival_time'] ?? null;
$duration = $_POST['duration'] ?? null;
$from_location = $_POST['from_location'] ?? null;
$to_location = $_POST['to_location'] ?? null;
$driver_name = $_POST['driver_name'] ?? null;
$driver_rating = $_POST['driver_rating'] ?? 0;
$driver_rides = $_POST['driver_rides'] ?? 0;
$driver_status = $_POST['driver_status'] ?? null;
$vehicle_type = $_POST['vehicle_type'] ?? null;
$seats = $_POST['seats'] ?? 0;
$tag = $_POST['tag'] ?? null;
$price = $_POST['price'] ?? 0;
$is_full = $_POST['is_full'] ?? 0;
$travel_date = $_POST['travel_date'] ?? null;

// Validate required fields
if (!$departure_time || !$arrival_time || !$from_location || !$to_location || !$driver_name || !$vehicle_type || !$travel_date) {
    echo json_encode(["status" => "error", "message" => "Missing required fields"]);
    exit;
}

// Convert time and date
$departure_time = date('H:i:s', strtotime(str_replace('.', ':', $departure_time)));
$arrival_time = date('H:i:s', strtotime(str_replace('.', ':', $arrival_time)));
$travel_date = date('Y-m-d', strtotime($travel_date));

// Insert query
try {
    $stmt = $pdo->prepare("
        INSERT INTO availableriderequest (
            departure_time, arrival_time, duration, from_location, to_location,
            driver_name, driver_rating, driver_rides, driver_status, vehicle_type,
            seats, tag, price, is_full, travel_date
        ) VALUES (
            :departure_time, :arrival_time, :duration, :from_location, :to_location,
            :driver_name, :driver_rating, :driver_rides, :driver_status, :vehicle_type,
            :seats, :tag, :price, :is_full, :travel_date
        )
    ");

    $stmt->execute([
        ':departure_time' => $departure_time,
        ':arrival_time' => $arrival_time,
        ':duration' => $duration,
        ':from_location' => $from_location,
        ':to_location' => $to_location,
        ':driver_name' => $driver_name,
        ':driver_rating' => $driver_rating,
        ':driver_rides' => $driver_rides,
        ':driver_status' => $driver_status,
        ':vehicle_type' => $vehicle_type,
        ':seats' => $seats,
        ':tag' => $tag,
        ':price' => $price,
        ':is_full' => $is_full,
        ':travel_date' => $travel_date
    ]);

    echo json_encode(["status" => "success", "message" => "Available ride added successfully"]);
} catch (PDOException $e) {
    echo json_encode(["status" => "error", "message" => "Insert failed: " . $e->getMessage()]);
}
?>
