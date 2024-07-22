<?php

namespace App\Commands;

use Longman\TelegramBot\Commands\Command;
use Longman\TelegramBot\Commands\UserCommand;
use Longman\TelegramBot\Entities\ServerResponse;
use Longman\TelegramBot\Request;
use App\ExampleGenerator;

class StartCommand extends UserCommand
{
    protected $name = 'start'; // Название команды
    protected $description = 'Start a telegram bot'; // Описание команды

    protected $usage = '/start';

    public function execute() : ServerResponse
    {
        $message = $this->getMessage(); // Получаем объект сообщения
        $chat_id = $message->getChat()->getId(); // Получаем ID чата, откуда пришло сообщение
        $example = new ExampleGenerator();
        $example->generate();
        $answer = $example->calculate();

        file_put_contents("/home/kirylwork/{$chat_id}.txt", $answer);
        // Текст ответного сообщения
        $text = "Привет! 👋

Я – бот, и у меня есть кое-что совершенно секретное для тебя. Но чтобы получить доступ к этой информации, тебе нужно решить одну задачку. 📚

Готов? Вот твой пример:

Если {$example->getExpression()}  = ?

Ответь правильно, и я открою тебе доступ к тайне! 🚀

Удачи!";

        // Формируем данные для отправки сообщения
        $data = [
            'chat_id' => $chat_id,
            'text'    => $text,
        ];

        // Отправляем сообщение через метод sendMessage класса Request
        return Request::sendMessage($data);
    }
}
