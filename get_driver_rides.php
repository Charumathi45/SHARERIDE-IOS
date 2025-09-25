<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

include 'config.php'; // Your DB connection file

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if (!isset($_GET['driver_id']) || empty($_GET['driver_id'])) {
        echo json_encode(["status" => "error", "message" => "Missing driver_id"]);
        exit;
    }

    $driver_id = intval($_GET['driver_id']); // Ensure integer

   $sql = "SELECT driver_id, pickup_location, drop_location, departure_date, available_seats, car_details, seat_price 
        FROM offerrides 
        WHERE driver_id = ?";



    $stmt = $conn->prepare($sql);

    if (!$stmt) {
        echo json_encode(["status" => "error", "message" => "Prepare failed: " . $conn->error]);
        exit;
    }

    $stmt->bind_param("i", $driver_id);
    $stmt->execute();
    $result = $stmt->get_result();

    $rides = [];
    while ($row = $result->fetch_assoc()) {
        $rides[] = $row;
    }

    if (!empty($rides)) {
        echo json_encode(["status" => "success", "rides" => $rides]);
    } else {
        echo json_encode(["status" => "error", "message" => "No rides found for this driver"]);
    }

    $stmt->close();
    $conn->close();
} else {
    echo json_encode(["status" => "error", "message" => "Invalid request method"]);
}
?>
