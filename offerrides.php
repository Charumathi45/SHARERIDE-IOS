<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

include 'config.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $driver_id = $_POST['driver_id'];
    $pickup_location = $_POST['pickup_location'];
    $drop_location = $_POST['drop_location'];
    $departure_date = $_POST['departure_date'];
    $available_seats = $_POST['available_seats'];
    $car_details = $_POST['car_details'];
    
    // ✅ Make seat_price optional
    $seat_price = isset($_POST['seat_price']) && $_POST['seat_price'] !== '' 
        ? $_POST['seat_price'] 
        : 0;

    $sql = "INSERT INTO offerrides (driver_id, pickup_location, drop_location, departure_date, available_seats, car_details, seat_price)
            VALUES (?, ?, ?, ?, ?, ?, ?)";

    $stmt = $conn->prepare($sql);

    if (!$stmt) {
        echo json_encode(["status" => "error", "message" => "Prepare failed: " . $conn->error]);
        exit;
    }

    // ✅ Change last type from "s" to "i" if seat_price is integer
    $stmt->bind_param("isssisi", $driver_id, $pickup_location, $drop_location, $departure_date, $available_seats, $car_details, $seat_price);

    if ($stmt->execute()) {
        echo json_encode(["status" => "success", "message" => "Ride posted successfully"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Execute failed: " . $stmt->error]);
    }

    $stmt->close();
    $conn->close();
} else {
    echo json_encode(["status" => "error", "message" => "Invalid request method"]);
}
?>
