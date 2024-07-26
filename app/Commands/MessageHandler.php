<?php

namespace App\Commands;

use App\Database\UserData;
use Longman\TelegramBot\Request;
use Longman\TelegramBot\Entities\Update;
use Longman\TelegramBot\Entities\Message;

class MessageHandler
{
    private $userData;

    public function __construct(UserData $userData)
    {
        $this->userData = $userData;
    }

    public function handle(): void
    {
        $input = file_get_contents('php://input');

        if ($input === false) {
            $this->log('Ошибка: Не удалось получить данные из запроса.');
            return;
        }

        $post = json_decode($input, true);

        if (json_last_error() !== JSON_ERROR_NONE) {
            $this->log('Ошибка: Неверный формат JSON. ' . json_last_error_msg());
            return;
        }

        $update = new Update($post, $_ENV['TELEGRAM_NAME']);

        if (!$update instanceof Update) {
            $this->log('Ошибка: Невозможно создать объект Update.');
            return;
        }

        $message = $update->getMessage();

        if (!$message instanceof Message) {
            $this->log('Ошибка: Сообщение не найдено.');
            return;
        }

        $text = $message->getText();
        $chat_id = $message->getChat()->getId();

        if ($chat_id === null) {
            $this->log('Ошибка: ID чата не найден.');
            return;
        }

        $this->log("Обработано сообщение: Chat ID: $chat_id, Text: $text");

        $stored_answer = $this->userData->getUserData($chat_id);

        if ($stored_answer) {
            $stored_answer = trim($stored_answer);
            if ($text === '/start') {
                return;
            }
            if ($text === $stored_answer) {
                $response_text = $_ENV['SECRET_INFO'];
                $this->userData->deleteUserData($chat_id);
                $this->log("Правильный ответ от Chat ID: $chat_id. Тайна отправлена.");
            } else {
                $response_text = "Упс\. Это не совсем правильно\. Попробуй еще раз\.";
                $this->log("Неправильный ответ от Chat ID: $chat_id. Ответ: $text");
            }
        } else {
            $this->log("Нет данных для проверки для Chat ID: $chat_id.");
            return;
        }

        $this->sendResponse($chat_id, $response_text);
    }

    private function sendResponse($chat_id, $response_text): void
    {
        if ($chat_id === null || $response_text === null) {
            return;
        }

        $data = [
            'chat_id'    => $chat_id,
            'text'       => $response_text,
            'parse_mode' => 'MarkdownV2'
        ];

        $result = Request::sendMessage($data);

        $this->log("Отправлено сообщение для Chat ID: $chat_id. Результат: " . print_r($result, true));
    }

    private function log(string $message): void
    {
        error_log($message);
    }

}