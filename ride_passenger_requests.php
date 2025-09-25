<?php
include 'config.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $ride_id = $_POST['ride_id'];

    $sql = "SELECT * FROM ride_passenger_requests WHERE ride_id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $ride_id);
    $stmt->execute();
    $result = $stmt->get_result();

    $requests = [];
    while ($row = $result->fetch_assoc()) {
        $requests[] = $row;
    }

    echo json_encode(["success" => true, "requests" => $requests]);
} else {
    echo json_encode(["success" => false, "message" => "Invalid request method"]);
}
?>
