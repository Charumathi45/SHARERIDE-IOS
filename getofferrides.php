<?php
header('Content-Type: application/json');
error_reporting(E_ALL);
ini_set('display_errors', 1);

include 'config.php'; // mysqli connection

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if (!isset($_GET['driver_id']) || !is_numeric($_GET['driver_id'])) {
        echo json_encode(["status" => false, "message" => "Missing or invalid driver_id"]);
        exit;
    }

    $driver_id = intval($_GET['driver_id']);

    $stmt = $conn->prepare("SELECT * FROM offerrides WHERE driver_id = ? ORDER BY id DESC");
    $stmt->bind_param("i", $driver_id);
    $stmt->execute();
    $result = $stmt->get_result();

    $rides = [];
    while ($row = $result->fetch_assoc()) {
        $rides[] = $row;
    }

    echo json_encode([
        "status" => true,
        "data" => $rides
    ]);

    $stmt->close();
    $conn->close();
} else {
    echo json_encode(["status" => false, "message" => "Invalid request method"]);
}
?>
