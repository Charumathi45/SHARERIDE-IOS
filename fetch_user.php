<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);
header('Content-Type: application/json');

include('config.php'); // Ensure $conn is set

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode([
        "success" => false,
        "message" => "Invalid request method. Use POST."
    ]);
    exit();
}

if (empty($_POST['id'])) {
    echo json_encode([
        "success" => false,
        "message" => "Missing field: id"
    ]);
    exit();
}

$id = intval($_POST['id']);

$sql = "SELECT id, name, email FROM user_signup WHERE id = $id LIMIT 1";
$result = $conn->query($sql);

if ($result && $result->num_rows > 0) {
    $user = $result->fetch_assoc();
    echo json_encode([
        "success" => true,
        "message" => "User found.",
        "data" => $user
    ]);
} else {
    echo json_encode([
        "success" => false,
        "message" => "User not found."
    ]);
}
?>
