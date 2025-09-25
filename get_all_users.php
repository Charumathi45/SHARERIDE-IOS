<?php
header('Content-Type: application/json');

// ✅ Only allow GET requests
if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    echo json_encode(["status" => false, "message" => "Invalid request method"]);
    exit();
}

// ✅ Include DB connection
include('config.php');

// ✅ Query all users
$sql = "SELECT id, name, email FROM user_signup";
$result = $conn->query($sql);

$users = [];
if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $users[] = $row;
    }

    echo json_encode([
        "status" => true,
        "data" => $users
    ]);
} else {
    echo json_encode([
        "status" => false,
        "message" => "No users found"
    ]);
}
?>
