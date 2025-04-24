<?php

declare(strict_types=1);

namespace App\Group;

class Group
{
    private int $id;

    private string $name;

    public array $members;

    public function __construct(int $id, string $name)
    {
        $this->id = $id;
        $this->name = strtolower($name);
		$this->members = [];
    }
	public function get(): int
    {
        return $this->id;
    }

    public function getName(): string
    {
        return $this->name;
    }
}