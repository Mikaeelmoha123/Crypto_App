<?php
// Database configuration
define('DB_HOST', 'localhost');
define('DB_USER', 'root');
define('DB_PASS', '');  // Default XAMPP MySQL has no password
define('DB_NAME', 'crypto');

// Create database connection
function getDBConnection() {
    try {
        $pdo = new PDO(
            "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=utf8mb4",
            DB_USER,
            DB_PASS,
            [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES => false,
            ]
        );
        return $pdo;
    } catch (PDOException $e) {
        error_log("Database connection failed: " . $e->getMessage());
        die(json_encode(['error' => 'Database connection failed']));
    }
}

// CORS headers for API access
function setCORSHeaders() {
    header('Access-Control-Allow-Origin: *');
    header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
    header('Access-Control-Allow-Headers: Content-Type, Authorization');
    header('Content-Type: application/json');
    
    // Handle preflight OPTIONS request
    if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
        http_response_code(200);
        exit();
    }
}

// Error handling
function sendError($message, $code = 400) {
    http_response_code($code);
    echo json_encode(['error' => $message]);
    exit();
}

// Success response
function sendSuccess($data, $message = '') {
    echo json_encode([
        'success' => true,
        'message' => $message,
        'data' => $data
    ]);
}

// Validate required fields
function validateRequired($data, $required_fields) {
    foreach ($required_fields as $field) {
        if (!isset($data[$field]) || empty($data[$field])) {
            sendError("Field '$field' is required");
        }
    }
}

// Sanitize input
function sanitizeInput($input) {
    return htmlspecialchars(trim($input), ENT_QUOTES, 'UTF-8');
}

// Generate session token
function generateSessionToken() {
    return bin2hex(random_bytes(32));
}

// Verify session token
function verifySession($token) {
    $pdo = getDBConnection();
    $stmt = $pdo->prepare("
        SELECT us.user_id, u.username, u.email 
        FROM user_sessions us 
        JOIN users u ON us.user_id = u.id 
        WHERE us.session_token = ? AND us.expires_at > NOW()
    ");
    $stmt->execute([$token]);
    return $stmt->fetch();
}

// Check if user is authenticated
function requireAuth() {
    $headers = getallheaders();
    $token = isset($headers['Authorization']) ? str_replace('Bearer ', '', $headers['Authorization']) : null;
    
    if (!$token) {
        sendError('Authentication required', 401);
    }
    
    $user = verifySession($token);
    if (!$user) {
        sendError('Invalid or expired session', 401);
    }
    
    return $user;
}
?>