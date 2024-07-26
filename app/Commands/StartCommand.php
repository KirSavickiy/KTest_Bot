<?php

namespace App\Commands;

use App\ExampleGenerator;
use Exception;
use Longman\TelegramBot\Commands\UserCommand;
use Longman\TelegramBot\Entities\ServerResponse;
use Longman\TelegramBot\Request;
use App\Database\UserData;

class StartCommand extends UserCommand
{
    protected $name = 'start';
    protected $description = 'Start a telegram bot';
    protected $usage = '/start';
    protected $userData;

    public function execute() : ServerResponse
    {
        try {
            $message = $this->getMessage();
            $chat_id = $message->getChat()->getId();

            $example = new ExampleGenerator();
            $example->generate();
            $answer = $example->calculate();

            $this->userData = new UserData();
            $this->userData->deleteUserData($chat_id);
            $this->userData->insertUserData($chat_id, $answer);

            // Логирование данных для отладки
            error_log('Chat ID: ' . $chat_id);
            error_log('Generated answer: ' . $answer);
            error_log('Generated expression: ' . $example->getExpression());

            $text = "Привет! 👋\n\n" .
                "Я – бот, и у меня есть кое-что совершенно секретное для тебя. Но чтобы получить доступ к этой информации, тебе нужно решить одну задачку. 📚\n\n" .
                "Готов? Вот твой пример:\n\n" .
                "Если {$example->getExpression()}  = ?\n\n" .
                "Ответь правильно, и я открою тебе доступ к тайне! 🚀\n\n" .
                "Удачи!";

            $data = [
                'chat_id' => $chat_id,
                'text'    => $text,
            ];

            // Логирование запроса
            error_log('Sending message: ' . print_r($data, true));

            return Request::sendMessage($data);

        } catch (Exception $e) {
            // Логирование ошибок
            error_log('Error in StartCommand: ' . $e->getMessage() . ' on line ' . $e->getLine() . ' in file ' . $e->getFile());
            return Request::emptyResponse();
        }
    }
}
