<?php

namespace App\Commands;

use Longman\TelegramBot\Entities\Update;
use Longman\TelegramBot\Request;

class MessageHandler
{
    public static function handle($update) : void
    {
        $text = null;
        $chat_id = null;
        $response_text = null;
        // Получаем сообщение из обновления
        $result = $update->getResult();
        foreach ($result as $update) {
            $message = $update->getMessage();
            if ($message === null) {
                echo 'error';
                return;
            }

            $text = $message->getText();
            $chat_id = $message->getChat()->getId();
        }
        $stored_answer_file = "/home/kirylwork/{$chat_id}.txt";

        if (str_starts_with($text, '/')) {
            // Команда не обрабатывается здесь
            return;
        }
        // Проверяем, существует ли файл
        if (file_exists($stored_answer_file)) {
            $stored_answer = trim(file_get_contents($stored_answer_file)); // Удаляем пробелы из ответа

            if ($text === $stored_answer) {
                $response_text = "Поздравляю! Ты ответил правильно!";
                // Удалите файл с правильным ответом после успешного ответа
                unlink($stored_answer_file);
            } else {
                $response_text = "Упс! Это не совсем правильно. Попробуй еще раз.";
            }
        }
        // Формируем данные для отправки сообщения
        $data = [
            'chat_id' => $chat_id,
            'text'    => $response_text,
        ];

        // Отправляем сообщение через метод sendMessage класса Request
        Request::sendMessage($data);
    }
}
