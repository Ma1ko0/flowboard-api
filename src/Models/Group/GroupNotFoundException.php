<?php

declare(strict_types=1);

namespace App\Group;

use Exception;

class GroupNotFoundException extends Exception
{
    public $message = 'The group you requested does not exist.';
}
