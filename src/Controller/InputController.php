<?php

namespace App;

use App\Board\BoardRepository;
use App\User\UserRepository;
use GroupRepository;

class InputController extends Controller
{
	public function __construct(string $method, array $uriParts) {
		parent::__construct($method, $uriParts);
	}

	public function processRequest(): void {
		$method = $this->getMethod();
		
		if ($method === "GET") {
			switch (strtolower($this->getUriParts()[0])) {
				case "boards":
					$this->shiftUriParts();
					$boardConroller = new BoardsController($this->getMethod(), $this->getUriParts());
					$boardConroller->processRequest();
				case "users":
						$this->shiftUriParts();
						if (empty($this->getUriParts())) {
							Response::error("User ID is required", 400);
						}
						$userrepo = new UserRepository();
						$userId = $this->getUriParts()[0];
						$user = $userrepo->getUserById($userId);
						if (empty($user)) {
							Logger::logging("User not found", ERROR);
							Response::error("User not found", 404);
						}
						Logger::logging("User found", INFO);
						Response::json($user->getUsername(), 200);
				case "groups":
					$this->shiftUriParts();
					if (empty($this->getUriParts())) {
						Response::error("Group ID is required", 400);
					}
					$grouprepo = new GroupRepository();
					$groupId = $this->getUriParts()[0];
					$group = $grouprepo->getGroupMembers($groupId);
					if (empty($group)) {
						Logger::logging("Group not found", ERROR);
						Response::error("Group not found", 404);
					}
					Logger::logging("Group found", INFO);
					Response::json($group, 200);
				default:
					break;
			}
			
		}
		if ($method === "POST") {
			switch (strtolower($this->getUriParts()[0])) {
				case "boards":
					$boardrepo = new BoardRepository();
					Logger::logging("Test");
					Response::json([$boardrepo->createBoardForuser("1", "Hello")], 200);
			}
		}
		Response::error("Method not allowed", 405);
	}
}
