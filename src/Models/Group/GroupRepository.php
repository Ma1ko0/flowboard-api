<?php

use App\Group\Group;
use App\Group\GroupNotFoundException;
use App\User\UserRepository;

class GroupRepository extends Repository
{
	private PDO $databaseConnection;

	public function __construct()
	{
		$this->databaseConnection = self::getConnection();
		if ($this->databaseConnection === null) {
			throw new \RuntimeException("Database connection failed");
		}
	}

	public function getAllGroups(): array
	{
		$table = self::TABLENAME_GROUP;
		$query = <<<SQL
			SELECT * FROM {$table}
		SQL;
		$stmt = $this->databaseConnection->prepare($query);
		$stmt->execute();
		$result = $stmt->fetchAll(PDO::FETCH_ASSOC);
		if (sizeof($result) == 0) {
			throw new GroupNotFoundException();
		}
		$groups = array_map([$this, 'mapToGroup'], $result);
		return $groups;
	}

	public function getUserGroups($userId): array
	{
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
		$table = self::TABLENAME_USERGROUP;
		$query = <<<SQL
			SELECT * FROM {$table} WHERE user_id = ?
		SQL;
		$stmt = $this->databaseConnection->prepare($query);
		$stmt->execute([$userId]);
		$result = $stmt->fetchAll(PDO::FETCH_ASSOC);
		if (sizeof($result) == 0) {
			throw new GroupNotFoundException();
		}
		$groups = array_map([$this, 'mapToGroup'], $result);
		return $groups;
	}
	public function getGroupMembers($groupId): array
	{
		if (empty($groupId)) {
			throw new \InvalidArgumentException("Group ID cannot be empty");
		}
		if (!is_string($groupId)) {
			throw new \InvalidArgumentException("Group ID must be a string");
		}
		if (strlen($groupId) > 255) {
			throw new \LengthException("Group ID is too long");
		}
		if (!preg_match("/^[a-zA-Z0-9]+$/", $groupId)) {
			throw new \InvalidArgumentException("Group ID contains invalid characters");
		}
		$table = self::TABLENAME_USERGROUP;
		$query = <<<SQL
			SELECT * FROM {$table} WHERE group_id = ?
		SQL;
		$stmt = $this->databaseConnection->prepare($query);
		$stmt->execute([$groupId]);
		$result = $stmt->fetchAll(PDO::FETCH_ASSOC);
		if (sizeof($result) == 0) {
			throw new GroupNotFoundException();
		}
		$userRepo = new UserRepository();
		$members = [];
		foreach ($result as $row) {
			$members[] = $userRepo->getUserById($row['user_id']);
		}
		return array_map([$userRepo, 'mapToUser'], $result);
	}
	public function mapToGroup($row)
	{
		return new Group(
			$row['id'],
			$row['name']
		);
	}
}
