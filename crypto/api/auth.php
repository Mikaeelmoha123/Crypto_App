<?ph
require_once 'config.php';

setCORSHeaders();

$method = $_SERVER['REQUEST_METHOD'];
$action = $_GET['action'] ?? '';

switch ($method) {
    case 'POST':
        switch ($action) {
            case 'login':
                login();
                break;
            case 'register':
                register();
                break;
            case 'logout':
                logout();
                break;
            default:
                sendError('Invalid action');
        }
        break;
        
    case 'GET':
        if ($action === 'verify') {
            verifyToken();
        } else {
            sendError('Invalid request');
        }
        break;
        
    default:
        sendError('Method not allowed', 405);
}

function login() {
    $input = json_decode(file_get_contents('php://input'), true);
    validateRequired($input, ['email', 'password']);
    
    $email = sanitizeInput($input['email']);
    $password = $input['password'];
    
    $pdo = getDBConnection();
    
    // Find user by email
    $stmt = $pdo->prepare("SELECT id, username, email, password_hash, is_active FROM users WHERE email = ?");
    $stmt->execute([$email]);
    $user = $stmt->fetch();
    
    if (!$user) {
        sendError('Invalid email or password', 401);
    }
    
    if (!$user['is_active']) {
        sendError('Account is deactivated', 401);
    }
    
    // Verify password (for demo user, password is "password")
    if (!password_verify($password, $user['password_hash'])) {
        sendError('Invalid email or password', 401);
    }
    
    // Create session
    $token = generateSessionToken();
    $expires_at = date('Y-m-d H:i:s', strtotime('+24 hours'));
    
    $stmt = $pdo->prepare("
        INSERT INTO user_sessions (user_id, session_token, ip_address, user_agent, expires_at) 
        VALUES (?, ?, ?, ?, ?)
    ");
    $stmt->execute([
        $user['id'],
        $token,
        $_SERVER['REMOTE_ADDR'] ?? '',
        $_SERVER['HTTP_USER_AGENT'] ?? '',
        $expires_at
    ]);
    
    sendSuccess([
        'token' => $token,
        'user' => [
            'id' => $user['id'],
            'username' => $user['username'],
            'email' => $user['email']
        ],
        'expires_at' => $expires_at
    ], 'Login successful');
}

function register() {
    $input = json_decode(file_get_contents('php://input'), true);
    validateRequired($input, ['username', 'email', 'password', 'first_name', 'last_name']);
    
    $username = sanitizeInput($input['username']);
    $email = sanitizeInput($input['email']);
    $password = $input['password'];
    $first_name = sanitizeInput($input['first_name']);
    $last_name = sanitizeInput($input['last_name']);
    
    // Validate email format
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        sendError('Invalid email format');
    }
    
    // Validate password strength
    if (strlen($password) < 6) {
        sendError('Password must be at least 6 characters long');
    }
    
    $pdo = getDBConnection();
    
    // Check if email or username already exists
    $stmt = $pdo->prepare("SELECT id FROM users WHERE email = ? OR username = ?");
    $stmt->execute([$email, $username]);
    if ($stmt->fetch()) {
        sendError('Email or username already exists');
    }
    
    // Hash password
    $password_hash = password_hash($password, PASSWORD_DEFAULT);
    
    try {
        $pdo->beginTransaction();
        
        // Create user
        $stmt = $pdo->prepare("
            INSERT INTO users (username, email, password_hash, first_name, last_name) 
            VALUES (?, ?, ?, ?, ?)
        ");
        $stmt->execute([$username, $email, $password_hash, $first_name, $last_name]);
        $user_id = $pdo->lastInsertId();
        
        // Create initial balances - give new users demo money
        $initial_balances = [
            'USD' => 10000,  // $10,000 demo money
            'BTC' => 0,
            'ETH' => 0,
            'ADA' => 0,
            'DOT' => 0,
            'LINK' => 0,
            'SOL' => 0,
            'MATIC' => 0,
            'AVAX' => 0
        ];
        
        foreach ($initial_balances as $asset => $amount) {
            $stmt = $pdo->prepare("
                INSERT INTO user_balances (user_id, asset, available_balance) 
                VALUES (?, ?, ?)
            ");
            $stmt->execute([$user_id, $asset, $amount]);
        }
        
        $pdo->commit();
        
        sendSuccess([
            'user_id' => $user_id,
            'username' => $username,
            'email' => $email
        ], 'Registration successful');
        
    } catch (Exception $e) {
        $pdo->rollBack();
        error_log("Registration error: " . $e->getMessage());
        sendError('Registration failed');
    }
}

function logout() {
    $user = requireAuth();
    $headers = getallheaders();
    $token = str_replace('Bearer ', '', $headers['Authorization']);
    
    $pdo = getDBConnection();
    $stmt = $pdo->prepare("DELETE FROM user_sessions WHERE session_token = ?");
    $stmt->execute([$token]);
    
    sendSuccess([], 'Logged out successfully');
}

function verifyToken() {
    $user = requireAuth();
    sendSuccess($user, 'Token is valid');
}
?>
