<?php

use App\Response;

class Repository {
	protected const TABLENAME_BOARDTOUSER = "boardToUser";
	protected const TABLENAME_BOARD = "board";
	protected const TABLENAME_BOARDTOGROUP = "boardToGroup";
	protected const TABLENAME_USER = "user";
	protected const TABLENAME_GROUP = "group";
	protected const TABLENAME_USERTOGROUP = "userToGroup";

	protected static $dbHost;
	protected static $dbName;
	protected static $dbUser;
	protected static $dbPassword;

	public static function init(): void
	{
		// Setze die Umgebungsvariablen
		self::$dbHost = getenv('DB_HOST') ?: 'localhost';  // Fallback auf 'localhost', wenn nicht gesetzt
		self::$dbName = getenv('DB_NAME') ?: 'mydatabase';
		self::$dbUser = getenv('DB_USER') ?: 'root';
		self::$dbPassword = getenv('DB_PASSWORD') ?: '12345678';
	}

	public static function getConnection(): ?PDO
	{
		// Stelle sicher, dass init() vorher aufgerufen wurde
		if (!isset(self::$dbHost)) {
			self::init();
		}

		try {
			$dsn = "mysql:host=" . self::$dbHost . ";dbname=" . self::$dbName;
			$pdo = new PDO($dsn, self::$dbUser, self::$dbPassword);
			$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
			return $pdo;
		} catch (PDOException $e) {
			Response::error("Database connection failed: " . $e->getMessage(), 500);
			return null;
		}
	}
}
