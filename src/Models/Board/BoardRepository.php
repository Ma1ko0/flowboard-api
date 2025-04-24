<?php

namespace App\Board;

use App\User\UserRepository;
use PDO;
use Repository;

class BoardRepository extends Repository{

	private PDO $databaseConnection;

	public function __construct()
	{
		$this->databaseConnection = new PDO("mysql:host=mydb;dbname=mydatabase;charset=utf8", "root", "12345678");
		$this->databaseConnection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	}
	public function getAllBoardsForUser($userId): array {
		if (empty($userId)) {
			throw new \InvalidArgumentException("User ID cannot be empty");
		}
		if (!is_string($userId)) {
			throw new \InvalidArgumentException("User ID must be a string");
		}
		if (strlen($userId) > 255) {
			throw new \LengthException("User ID is too long");
		}
		if (!preg_match("/^[a-zA-Z0-9]+$/", $userId)) {
			throw new \InvalidArgumentException("User ID contains invalid characters");
		}
		$table = self::TABLENAME_BOARD;
		$query = <<<SQL
			SELECT * FROM {$table} WHERE user_id = ?
		SQL;
		$stmt = $this->databaseConnection->prepare($query);
		$stmt->execute([$userId]);
		$result = $stmt->fetchAll(PDO::FETCH_ASSOC);
		if (sizeof($result) == 0) {
			throw new BoardNotFoundException();
		}
		$boards = array_map([$this, 'mapRowToBoard'], $result);
		return $boards;
	}

	public function createBoardForuser($userId, $name) {
		if (empty($userId) || empty($name)) {
			throw new \InvalidArgumentException("User ID and name cannot be empty");
		}
		if (!is_string($userId) || !is_string($name)) {
			throw new \InvalidArgumentException("User ID and name must be strings");
		}
		if (strlen($userId) > 255 || strlen($name) > 255) {
			throw new \LengthException("User ID and name are too long");
		}
		if (!preg_match("/^[a-zA-Z0-9]+$/", $userId) || !preg_match("/^[a-zA-Z0-9 ]+$/", $name)) {
			throw new \InvalidArgumentException("User ID or name contains invalid characters");
		}
		$table = self::TABLENAME_BOARD;
		$query = <<<SQL
			INSERT INTO {$table} (name, user_id) VALUES (?, ?)
		SQL;

		$stmt = $this->databaseConnection->prepare($query);
		$result = $stmt->execute([$name, $userId]);
		return $result ?? false;
	}
	private function mapRowToBoard(array $row): Board
	{
		return new Board(
			$row["id"],
			$row["name"],
			$row["user_id"],
			$row["group_id"],
			$row["created_at"]
		);
	}
}