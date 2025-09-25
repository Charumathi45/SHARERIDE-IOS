<?php
header("Content-Type: application/json");
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Database connection
$host = "localhost";
$db = "ShareRide";
$user = "root";
$pass = "";
$charset = "utf8mb4";

$dsn = "mysql:host=$host;dbname=$db;charset=$charset";

try {
    $pdo = new PDO($dsn, $user, $pass, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
    ]);
} catch (PDOException $e) {
    echo json_encode(["status" => "error", "message" => "DB Connection failed: " . $e->getMessage()]);
    exit;
}

// ✅ Required fields
$required = ["pickup_location", "dropoff_location", "departure_date", "seat_price", "passenger_name", "seats_booked"];

foreach ($required as $field) {
    if (empty($_POST[$field])) {
        echo json_encode(["status" => "error", "message" => "Missing field: $field"]);
        exit;
    }
}

// ✅ Collect values
$pickup_location = $_POST["pickup_location"];
$dropoff_location = $_POST["dropoff_location"];
$departure_date = $_POST["departure_date"];
$seat_price = $_POST["seat_price"];
$passenger_name = $_POST["passenger_name"];
$seats_booked = intval($_POST["seats_booked"]);
$rating = isset($_POST["rating"]) ? intval($_POST["rating"]) : null;
$feedback = isset($_POST["feedback"]) ? $_POST["feedback"] : null;

// ✅ Calculate total fare
$total_fare = $seat_price * $seats_booked;

try {
    $stmt = $pdo->prepare("INSERT INTO ride_completed 
        (pickup_location, dropoff_location, departure_date, seat_price, passenger_name, seats_booked, total_fare, rating, feedback) 
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
    
    $stmt->execute([
        $pickup_location,
        $dropoff_location,
        $departure_date,
        $seat_price,
        $passenger_name,
        $seats_booked,
        $total_fare,
        $rating,
        $feedback
    ]);

    echo json_encode(["status" => "success", "message" => "Ride completed record saved successfully"]);

} catch (PDOException $e) {
    echo json_encode(["status" => "error", "message" => "DB Insert failed: " . $e->getMessage()]);
}
?>
