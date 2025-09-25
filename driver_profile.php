<?php
header("Content-Type: application/json");

// Database config
$host = "localhost";
$db   = "shareride";
$user = "root";
$pass = "";

// Connect DB
$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    echo json_encode(["success" => false, "message" => "DB connection failed"]);
    exit();
}

// Collect POST data
$email     = $_POST['email'] ?? '';
$emergency = $_POST['emergency_contact'] ?? '';
$address   = $_POST['address'] ?? '';
$blood     = $_POST['blood_group'] ?? '';

// Validate
if (empty($email)) {
    echo json_encode(["success" => false, "message" => "Email is required"]);
    exit();
}

// Check if profile exists
$check = $conn->query("SELECT id FROM driver_profiles WHERE email='$email' LIMIT 1");

if ($check && $check->num_rows > 0) {
    // Update
    $sql = "UPDATE driver_profiles 
            SET emergency_contact='$emergency', address='$address', blood_group='$blood'
            WHERE email='$email'";
    if ($conn->query($sql)) {
        echo json_encode(["success" => true, "message" => "Profile updated"]);
    } else {
        echo json_encode(["success" => false, "message" => "Update failed"]);
    }
} else {
    // Insert
    $sql = "INSERT INTO driver_profiles (email, emergency_contact, address, blood_group)
            VALUES ('$email', '$emergency', '$address', '$blood')";
    if ($conn->query($sql)) {
        echo json_encode(["success" => true, "message" => "Profile created"]);
    } else {
        echo json_encode(["success" => false, "message" => "Insert failed"]);
    }
}

$conn->close();
?>
