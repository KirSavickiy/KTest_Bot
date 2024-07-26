<?php
require __DIR__ . '/vendor/autoload.php';

use Longman\TelegramBot\Telegram;

$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();

$bot_api_key  = $_ENV['TELEGRAM_BOT_TOKEN'];
$bot_username = $_ENV['TELEGRAM_NAME'];
$hook_url     = $_ENV['HOOK_URL'];

try {
    // Создание объекта Telegram API
    $telegram = new Telegram($bot_api_key, $bot_username);
    // Установка вебхука
    $result = $telegram->setWebhook($hook_url);
    if ($result->isOk()) {
        echo 'Webhook установлен успешно: ' . $result->getDescription();
    } else {
        echo 'Ошибка установки вебхука: ' . $result->getDescription();
    }
} catch (Longman\TelegramBot\Exception\TelegramException $e) {
    // Логирование ошибок Telegram
    echo $e->getMessage();
}
?>
