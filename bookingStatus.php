<?php
// bookingStatus.php
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

// ===== Insert New Booking =====
if ($method === 'POST') {
    $required = [
        'user_id', 'from_location', 'to_location', 'departure_address', 'arrival_address',
        'duration', 'fare', 'seats_available', 'driver_name', 'driver_rating', 'driver_verified',
        'boot_space', 'car_model'
    ];
    
    foreach ($required as $field) {
        if (!isset($_POST[$field])) {
            echo json_encode(["status" => "error", "message" => "Missing field: $field"]);
            exit;
        }
    }

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

// ===== Get All Bookings from Everyone =====
} elseif ($method === 'GET') {
    $stmt = $conn->prepare("SELECT * FROM booking_page ORDER BY booking_time DESC");
    $stmt->execute();

    $bookings = $stmt->fetchAll();

    if ($bookings && count($bookings) > 0) {
        echo json_encode([
            "status" => "success",
            "bookings" => $bookings
        ]);
    } else {
        echo json_encode([
            "status" => "error",
            "message" => "No bookings found"
        ]);
    }

// ===== Unsupported Method =====
} else {
    echo json_encode(["status" => "error", "message" => "Unsupported request method"]);
}
?>
