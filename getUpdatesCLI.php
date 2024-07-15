<?php
require __DIR__ . '/vendor/autoload.php';

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
    // Create Telegram API object
    $telegram = new Longman\TelegramBot\Telegram($bot_api_key, $bot_username);

    // Enable MySQL
    $telegram->enableMySql($mysql_credentials);

  //  $telegram->addCommandsPath(__DIR__ . '/Commands');
    // Handle telegram getUpdates request
    $server_response = $telegram->handleGetUpdates();

    if ($server_response->isOk()) {
       $result = $server_response->getResult();
       foreach($result as $message_item){
            $message = $message_item->getMessage();
       }
    }


} catch (Longman\TelegramBot\Exception\TelegramException $e) {
    // log telegram errors
    echo $e->getMessage();
}