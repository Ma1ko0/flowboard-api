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
	public function getAllBoardsForUser($userId) {
		// Hiermit zurück geben		header("Content-type: application/json; charset=UTF-8");
		$user = new UserRepository()->getUserById($userId);
		
		$stmt = $this->databaseConnection->query("SELECT * FROM boards WHERE user_id=$userId or group_id in " . $user["groups"] . " ");
		$result = $stmt->fetchAll(PDO::FETCH_ASSOC);
		return $result;
	}

	public function createBoardForuser($userId, $name) {
		$stmt = $this->databaseConnection->prepare("INSERT INTO ". self::TABLENAME_BOARD . "(name) VALUES (?)");
		$id = $stmt->execute([$name]);
		$id = $id ? $this->databaseConnection->lastInsertId() : false;
		if ($id !== false) {
			$stmt = $this->databaseConnection->prepare("INSERT INTO " . self::TABLENAME_BOARDTOUSER . " (userId, boardId) VALUES (?,?)");
			$result = $stmt->execute([$userId, $id]);
		}
		return $result ?? false;
	}
}