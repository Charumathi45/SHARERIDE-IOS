<?php
// Enable error reporting
ini_set('display_errors', 1);
error_reporting(E_ALL);

// Set content type
header('Content-Type: application/json');

// ✅ Database connection only
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "ShareRide";
$socket = "/Applications/XAMPP/xamppfiles/var/mysql/mysql.sock";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname, null, $socket);

// Check connection
if ($conn->connect_error) {
    echo json_encode([
        "success" => false,
        "message" => "Connection failed: " . $conn->connect_error
    ]);
    exit();
}
?>
