# Telegram Bot in PHP

This project is a Telegram bot written in PHP 8.2 using the `telegram-bot` library and webhooks for handling updates. The bot also interacts with a database and uses a `.env` file for storing sensitive data.

## Description

The bot provides users with access to top-secret information after successfully solving a math problem. When a new user starts interacting with the bot, the bot greets them and explains that access to the secret information is granted only after solving the problem. The user can request a problem, submit an answer, and if the answer is correct, the bot grants access to the secret information. If the answer is incorrect, the bot prompts the user to try again. The problems are unique for each user.

## Prerequisites

- PHP 8.2
- Composer
- Web server (e.g., Apache, Nginx)
- Database (e.g., MySQL)

## Installation

1. Clone the repository:

    ```bash
    git clone git@github.com:KirSavickiy/KTest_Bot.git
    cd your-repository
    ```

2. Install dependencies using Composer:

    ```bash
    composer install
    ```

3. Create a `.env` file in the root directory and add the following lines, replacing the placeholders with real values:

    ```env
    TELEGRAM_BOT_TOKEN='YOUR TELEGRAM_BOT_TOKEN'
    TELEGRAM_NAME='YOUR_TELEGRAM_NAME'
    LOG_FILE='PATH TO YOUR LOG FILE'
    HOOK_URL='YOUR WEBHOOK_URL'
    SECRET_INFO='YOUR SECRET INFO'
   
    #Database
    DB_HOST=''
    DB_NAME='telegram_bd'
    DB_USER=''
    DB_PASS=''
    ```

4. Set up the webhook for your bot. Run the following request:

    ```bash
    https://api.telegram.org/<TELEGRAM_BOT_TOKEN>/setWebhook?url=<HOOK_URL>
    ```

5. Set up the database. Import the `database.sql` file located in the repository:

    ```bash
    mysql -u your_user -p your_database < telegram_bd.sql
    ```

## Usage

1. Deploy all the files from the repository to your server.

2. Ensure that the `index.php` file is accessible at the URL specified in the `.env` file (`HOOK_URL`).

3. Check the log file (default `/var/log/telegram_bot.log`) for debugging and monitoring.


## Contributing

If you wish to contribute to the project, fork the repository and send a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.


