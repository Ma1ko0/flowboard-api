<?php

namespace App;

use App\Board\BoardRepository;
use App\User\UserRepository;

class BoardsController extends Controller
{
	public function __construct(string $method, array $uriParts) {
		parent::__construct($method, $uriParts);
	}

	public function processRequest(): void {
		$method = $this->getMethod();
		
		if ($method === "GET") {
			if (empty($this->getUriParts())) {
				Response::error("Method not allowed", 405);
			}
			switch (strtolower($this->getUriParts()[0])) {
				case "all":
					$this->shiftUriParts();
					if (empty($this->getUriParts())) {
						Response::error("User ID is required", 400);
					}
					$boardrepo = new BoardRepository();
					$userId = $this->getUriParts()[0];
					$boards = $boardrepo->getAllBoardsForUser($userId);
					if (empty($boards)) {
						Logger::logging("No boards found for user", ERROR);
						Response::error("No boards found for user", 404);
					}
					Logger::logging("Boards found for user", INFO);
					Response::json($boards, 200);
				default:
					break;
			}
		}

		Response::error("Method not allowed", 405);
	}
}