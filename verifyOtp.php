<?php
header('Content-Type: application/json');

$host = "localhost";
$db   = "ShareRide";
$user = "root";
$pass = "";
$charset = "utf8mb4";

$dsn = "mysql:host=$host;dbname=$db;charset=$charset";
$options = [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION];
$conn = new PDO($dsn, $user, $pass, $options);

$user_id = $_POST['user_id'] ?? null;
$otp     = $_POST['otp'] ?? null;

if(!$user_id || !$otp){
    echo json_encode(["status" => "error", "message" => "Missing parameters"]);
    exit;
}

$stmt = $conn->prepare("SELECT * FROM ride_otps WHERE user_id = ? AND otp = ? ORDER BY id DESC LIMIT 1");
$stmt->execute([$user_id, $otp]);
$result = $stmt->fetch(PDO::FETCH_ASSOC);

if($result){
    echo json_encode(["status" => "success", "message" => "OTP verified"]);
} else {
    echo json_encode(["status" => "error", "message" => "Invalid OTP"]);
}
?>
