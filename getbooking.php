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

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    echo json_encode(["status" => "error", "message" => "Invalid request method"]);
    exit;
}

if (!isset($_GET['user_id'])) {
    echo json_encode(["status" => "error", "message" => "Missing user_id"]);
    exit;
}

$user_id = $_GET['user_id'];

// Fetch all bookings for the user
$stmt = $conn->prepare("SELECT * FROM booking_page WHERE user_id = ? ORDER BY booking_time DESC");
$stmt->execute([$user_id]);
$bookings = $stmt->fetchAll();

if (!empty($bookings)) {
    echo json_encode([
        "status" => "success",
        "data" => array_values($bookings)  // ensure it's an indexed array
    ]);
} else {
    echo json_encode([
        "status" => "success",
        "data" => []  // still return an array, even if empty
    ]);
}
?>
