hp<?php
require_once 'api/config.php';

try {
    $pdo = getDBConnection();
    echo "<h2>✅ Database Connection Successful!</h2>";
    
    // Test query
    $stmt = $pdo->query("SELECT COUNT(*) as user_count FROM users");
    $result = $stmt->fetch();
    echo "<p>Users in database: " . $result['user_count'] . "</p>";
    
    // Test cryptocurrencies
    $stmt = $pdo->query("SELECT symbol, name, current_price FROM cryptocurrencies ");
    echo "<h3>Sample Cryptocurrencies:</h3>";
    echo "<table border='1'>";
    echo "<tr><th>Symbol</th><th>Name</th><th>Price</th></tr>";
    while ($row = $stmt->fetch()) {
        echo "<tr><td>{$row['symbol']}</td><td>{$row['name']}</td><td>\${$row['current_price']}</td></tr>";
    }
    echo "</table>";
    
} catch (Exception $e) {
    echo "<h2>❌ Database Connection Failed!</h2>";
    echo "<p>Error: " . $e->getMessage() . "</p>";
}
?>


