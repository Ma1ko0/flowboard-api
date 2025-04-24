<?php

namespace App\Board;

class Board {
	public int $id;
	public string $name;
	public ?int $user_id;
	public ?int $group_id;

	public function __construct(?int $id, string $name, ?int $user_id, ?int $group_id)
    {
        $this->id = $id;
        $this->name = strtolower($name);
        $this->user_id = $user_id;
        $this->group_id = $group_id;
    }

    public function getId() : int {
        return $this->id;
    }
}