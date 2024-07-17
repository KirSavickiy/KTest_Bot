<?php

namespace Longman\TelegramBot;

use Longman\TelegramBot\Commands\UserCommand;
use Longman\TelegramBot\Entities\Keyboard;
use Longman\TelegramBot\Entities\KeyboardButton;
use Longman\TelegramBot\Request;



class StartCommand extends UserCommand
{
    protected $name = 'start';
    protected $description = 'Starts a telegram bot';
    protected $version = '1.0.0';
    protected $usage = '/start';

    public function execute(){
        // DATABASE
        $host = 'localhost';
        $db = 'dbname';
        $user = 'dbuser';
        $pass = 'dbpass';

}








}