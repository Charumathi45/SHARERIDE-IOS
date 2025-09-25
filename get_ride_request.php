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
    $conn = new PDO($dsn, $user, $pass, $options);

    // Fetch all ride requests
    $stmt = $conn->query("SELECT * FROM offerrides ORDER BY id DESC");
    $rideRequests = $stmt->fetchAll();

    echo json_encode([
        "status" => "success",
        "requests" => $rideRequests
    ]);
    
} catch (PDOException $e) {
    echo json_encode([
        "status" => "error",
        "message" => "Fetch failed: " . $e->getMessage()
    ]);
}
