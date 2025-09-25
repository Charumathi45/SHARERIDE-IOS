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

// PDO connection
$dsn = "mysql:host=$host;dbname=$db;charset=$charset";
$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
];

try {
    $conn = new PDO($dsn, $user, $pass, $options);
} catch (PDOException $e) {
    echo json_encode(["status" => "error", "message" => "Database connection failed"]);
    exit;
}

// Collect POST input
$user_id = $_POST['user_id'] ?? null;
$otp     = $_POST['otp'] ?? null;

// Input validation
if (!$user_id) {
    echo json_encode(["status" => "error", "message" => "Missing user_id"]);
    exit;
}
if (!$otp) {
    echo json_encode(["status" => "error", "message" => "Missing otp"]);
    exit;
}

// Verify OTP
$stmt = $conn->prepare("SELECT * FROM verify_request_otp WHERE user_id = ? AND otp = ?");
$stmt->execute([$user_id, $otp]);
$result = $stmt->fetch();

if ($result) {
    echo json_encode(["status" => "success", "message" => "OTP verified"]);
} else {
    echo json_encode(["status" => "error", "message" => "Invalid OTP"]);
}
?>
