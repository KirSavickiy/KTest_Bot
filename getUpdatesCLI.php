<?php
require __DIR__ . '/vendor/autoload.php';

use Longman\TelegramBot\Entities\Keyboard;
use Longman\TelegramBot\Entities\KeyboardButton;
use Longman\TelegramBot\Request;
use Longman\TelegramBot\Telegram;

$bot_api_key  = '7111486523:AAF-9U-GV1d4-Y3NtYosGVXoRG3DkczvZJM';
$bot_username = 'KTestX_bot';

$mysql_credentials = [
    'host'     => 'localhost',
    'port'     => 17039, // optional
    'user'     => 'dbuser',
    'password' => 'dbpass',
    'database' => 'dbname',
];

try {
    // Создание объекта Telegram API
    $telegram = new Telegram($bot_api_key, $bot_username);

    // Включение MySQL (если используется)
    $telegram->useGetUpdatesWithoutDatabase();

    // Обработка запросов getUpdates
    $server_response = $telegram->handleGetUpdates();

    if ($server_response->isOk()) {
        $result = $server_response->getResult();
        foreach ($result as $update) {
            $message = $update->getMessage();
            if ($message !== null) {
                $chat_id = $message->getChat()->getId();
                $text = $message->getText();

                if ($text === '/start') {
                    // Создание клавиатуры
                    $keyboard = [
                        'inline_keyboard' => [
                            [
                                ['text' => 'Получить пример', 'callback_data' => 'example'],
                                ['text' => 'Открыть секретную информацию', 'callback_data' => 'secret_info']
                            ]
                        ]
                    ];
                    $encodedKeyboard = json_encode($keyboard);

                    $data = [
                        'chat_id' => $chat_id,
                        'text'    => 'Тестовое сообщение с клавиатурой',
                        'reply_markup' => $encodedKeyboard
                    ];

                    $response = Request::sendMessage($data);

                    if ($response->isOk()) {
                        echo 'Сообщение отправлено успешно!';
                    } else {
                        echo 'Ошибка: ' . $response->getDescription();
                    }
                }
            }
        }
    } else {
        echo 'Ошибка: ' . $server_response->getDescription();
    }
} catch (Longman\TelegramBot\Exception\TelegramException $e) {
    // Логирование ошибок Telegram
    echo $e->getMessage();
}
?>
