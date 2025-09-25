<?php
header('Content-Type: application/json');
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Database connection
$host = 'localhost';
$db   = 'ShareRide';
$user = 'root';
$pass = '';
$charset = 'utf8mb4';

$dsn = "mysql:host=$host;dbname=$db;charset=$charset";
$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
];

try {
    $pdo = new PDO($dsn, $user, $pass, $options);
} catch (PDOException $e) {
    echo json_encode(['status' => 'error', 'message' => 'Database connection failed']);
    exit;
}

// Get POST data
$user_id  = $_POST['user_id'] ?? null;
$latitude = $_POST['latitude'] ?? null;
$longitude= $_POST['longitude'] ?? null;
$message  = $_POST['message'] ?? null;

// Check required fields
if (!$user_id || !$latitude || !$longitude || !$message) {
    echo json_encode(['status' => 'error', 'message' => 'Missing required fields']);
    exit;
}

// Insert SOS data into database
$stmt = $pdo->prepare("INSERT INTO sos_alerts (user_id, latitude, longitude, message) VALUES (?, ?, ?, ?)");
if ($stmt->execute([$user_id, $latitude, $longitude, $message])) {
    echo json_encode(['status' => 'success', 'message' => 'SOS alert sent successfully']);
} else {
    echo json_encode(['status' => 'error', 'message' => 'Failed to send SOS alert']);
}
?>
s