<?php
header('Content-Type: application/json');
ini_set('display_errors', 1);
error_reporting(E_ALL);

// Database connection
$host = 'localhost';
$db   = 'ShareRide';
$user = 'root';
$pass = '';
$charset = 'utf8mb4';

$dsn = "mysql:host=$host;dbname=$db;charset=$charset";
$options = [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
];

try {
    $conn = new PDO($dsn, $user, $pass, $options);
} catch (PDOException $e) {
    echo json_encode(["status" => "error", "message" => "Database connection failed"]);
    exit;
}

$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'POST') {
    // Required fields
    $required = ['user_id', 'from_location', 'to_location', 'departure_address', 'arrival_address', 'duration', 'fare', 'seats_available', 'driver_name', 'driver_rating', 'driver_verified', 'boot_space', 'car_model'];
    
    foreach ($required as $field) {
        if (!isset($_POST[$field])) {
            echo json_encode(["status" => "error", "message" => "Missing field: $field"]);
            exit;
        }
    }

    // Insert booking into DB
    $stmt = $conn->prepare("INSERT INTO booking_page (
        user_id, from_location, to_location, departure_address, arrival_address,
        duration, fare, seats_available, driver_name, driver_rating, driver_verified,
        boot_space, car_model
    ) VALUES (
        :user_id, :from_location, :to_location, :departure_address, :arrival_address,
        :duration, :fare, :seats_available, :driver_name, :driver_rating, :driver_verified,
        :boot_space, :car_model
    )");

    $stmt->execute([
        ':user_id' => $_POST['user_id'],
        ':from_location' => $_POST['from_location'],
        ':to_location' => $_POST['to_location'],
        ':departure_address' => $_POST['departure_address'],
        ':arrival_address' => $_POST['arrival_address'],
        ':duration' => $_POST['duration'],
        ':fare' => $_POST['fare'],
        ':seats_available' => $_POST['seats_available'],
        ':driver_name' => $_POST['driver_name'],
        ':driver_rating' => $_POST['driver_rating'],
        ':driver_verified' => $_POST['driver_verified'],
        ':boot_space' => $_POST['boot_space'],
        ':car_model' => $_POST['car_model']
    ]);

    echo json_encode(["status" => "success", "message" => "Booking inserted successfully"]);

} elseif ($method === 'GET') {
    if (!isset($_GET['user_id'])) {
        echo json_encode(["status" => "error", "message" => "Missing user_id"]);
        exit;
    }

    $user_id = $_GET['user_id'];

    $stmt = $conn->prepare("SELECT * FROM booking_page WHERE user_id = ? ORDER BY booking_time DESC LIMIT 1");
    $stmt->execute([$user_id]);

    $booking = $stmt->fetch();

    if ($booking) {
        echo json_encode(["status" => "success", "booking" => $booking]);
    } else {
        echo json_encode(["status" => "error", "message" => "No booking found"]);
    }

} else {
    echo json_encode(["status" => "error", "message" => "Unsupported request method"]);
}
?>
