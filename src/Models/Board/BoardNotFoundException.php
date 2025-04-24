<?php

declare(strict_types=1);

namespace App\Board;

use Exception;

class BoardNotFoundException extends Exception
{
    public $message = 'The board you requested does not exist.';
}
