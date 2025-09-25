<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);
header('Content-Type: application/json');

include('config.php'); // Assumes $conn is your MySQLi connection

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode([
        "success" => false,
        "message" => "Invalid request method. Use POST."
    ]);
    exit();
}

$admin_id = $_POST['admin_id'] ?? '';

if (empty($admin_id)) {
    echo json_encode([
        "success" => false,
        "message" => "Missing admin_id."
    ]);
    exit();
}

// Prepare the SQL query to fetch admin data (without phone)
$query = "SELECT admin_id, email FROM admin_signup WHERE admin_id = ?";
$stmt = $conn->prepare($query);

if (!$stmt) {
    echo json_encode([
        "success" => false,
        "message" => "Failed to prepare statement: " . $conn->error
    ]);
    exit();
}

$stmt->bind_param("s", $admin_id);
$stmt->execute();
$result = $stmt->get_result();

if ($result && $result->num_rows > 0) {
    $admin = $result->fetch_assoc();
    echo json_encode([
        "success" => true,
        "message" => "Admin profile fetched.",
        "data" => $admin
    ]);
} else {
    echo json_encode([
        "success" => false,
        "message" => "Admin not found."
    ]);
}

$stmt->close();
$conn->close();
?>
