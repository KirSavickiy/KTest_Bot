<?php

namespace App\Database;
use Longman\TelegramBot\DB;
use PDO;

class UserData
{
    protected $pdo;
    public function __construct(){
    $this->pdo = DB::getPdo();
}
public function deleteUserData (int $chat_id) : void
{
    $stmt = $this->pdo->prepare("DELETE FROM user_data WHERE chat_id = :chat_id");
    $stmt->execute(['chat_id' => $chat_id]);
}
public function insertUserData (int $chat_id, string $data) : void
{
    $stmt = $this->pdo->prepare("INSERT INTO user_data (chat_id, data) VALUES (:chat_id, :data)");
    $stmt->execute(['chat_id' => $chat_id, 'data' => $data]);
}

    public function getUserData(int $chat_id): ?string
    {
        $stmt = $this->pdo->prepare("SELECT data FROM user_data WHERE chat_id = :chat_id");
        $stmt->execute(['chat_id' => $chat_id]);
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        return $row ? trim($row['data']) : null;
    }

}