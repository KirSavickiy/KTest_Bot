<?php
require __DIR__ . '/vendor/autoload.php';

use Longman\TelegramBot\Telegram;
use App\Commands\StartCommand;
use App\Commands\MessageHandler;
use App\Database\UserData;

$logFile = $_ENV['LOG_FILE'];

function logMessage($message, $file) {
    file_put_contents($file, $message . "\n", FILE_APPEND);
}

$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

$bot_api_key  = $_ENV['TELEGRAM_BOT_TOKEN'];
$bot_username = $_ENV['TELEGRAM_NAME'];

$mysql_credentials = [
    'host'     => $_ENV['DB_HOST'],
    'user'     => $_ENV['DB_USER'],
    'password' => $_ENV['DB_PASS'],
    'database' => $_ENV['DB_NAME']
];

try {
    // Создание объекта Telegram API
    $telegram = new Telegram($bot_api_key, $bot_username);

    // Включение MySQL (если используется)
    $telegram->enableMySql($mysql_credentials);

    // Добавление команд
    $telegram->addCommandClass(StartCommand::class);

    // Обработка запроса
    logMessage("Handling request...", $logFile);
    $server_response = $telegram->handle();
    logMessage("Server Response: " . print_r($server_response, true), $logFile);

    // Создание объектов для обработки сообщений
    $userData = new UserData();
    $messageHandler = new MessageHandler($userData);
    $messageHandler->handle();

} catch (Longman\TelegramBot\Exception\TelegramException $e) {
    // Логирование ошибок Telegram
    logMessage("Telegram Error: " . $e->getMessage(), $logFile);
}
