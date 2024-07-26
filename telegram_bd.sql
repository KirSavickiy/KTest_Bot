-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Июл 26 2024 г., 15:24
-- Версия сервера: 10.4.28-MariaDB
-- Версия PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `telegram_bd`
--

-- --------------------------------------------------------

--
-- Структура таблицы `callback_query`
--

CREATE TABLE `callback_query` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Unique identifier for this query',
  `user_id` bigint(20) DEFAULT NULL COMMENT 'Unique user identifier',
  `chat_id` bigint(20) DEFAULT NULL COMMENT 'Unique chat identifier',
  `message_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'Unique message identifier',
  `inline_message_id` char(255) DEFAULT NULL COMMENT 'Identifier of the message sent via the bot in inline mode, that originated the query',
  `chat_instance` char(255) NOT NULL DEFAULT '' COMMENT 'Global identifier, uniquely corresponding to the chat to which the message with the callback button was sent',
  `data` char(255) NOT NULL DEFAULT '' COMMENT 'Data associated with the callback button',
  `game_short_name` char(255) NOT NULL DEFAULT '' COMMENT 'Short name of a Game to be returned, serves as the unique identifier for the game',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `chat`
--

CREATE TABLE `chat` (
  `id` bigint(20) NOT NULL COMMENT 'Unique identifier for this chat',
  `type` enum('private','group','supergroup','channel') NOT NULL COMMENT 'Type of chat, can be either private, group, supergroup or channel',
  `title` char(255) DEFAULT '' COMMENT 'Title, for supergroups, channels and group chats',
  `username` char(255) DEFAULT NULL COMMENT 'Username, for private chats, supergroups and channels if available',
  `first_name` char(255) DEFAULT NULL COMMENT 'First name of the other party in a private chat',
  `last_name` char(255) DEFAULT NULL COMMENT 'Last name of the other party in a private chat',
  `is_forum` tinyint(1) DEFAULT 0 COMMENT 'True, if the supergroup chat is a forum (has topics enabled)',
  `all_members_are_administrators` tinyint(1) DEFAULT 0 COMMENT 'True if a all members of this group are admins',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date update',
  `old_id` bigint(20) DEFAULT NULL COMMENT 'Unique chat identifier, this is filled when a group is converted to a supergroup',
  `chat_boost_updated_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `chat_boost_removed`
--

CREATE TABLE `chat_boost_removed` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Unique identifier for this entry',
  `chat_id` bigint(20) DEFAULT NULL COMMENT 'Chat which was boosted',
  `boost_id` varchar(200) NOT NULL COMMENT 'Unique identifier of the boost',
  `remove_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Point in time (Unix timestamp) when the boost was removed',
  `source` text NOT NULL COMMENT 'Source of the removed boost',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `chat_boost_updated`
--

CREATE TABLE `chat_boost_updated` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Unique identifier for this entry',
  `chat_id` bigint(20) DEFAULT NULL COMMENT 'Chat which was boosted',
  `boost` text NOT NULL COMMENT 'Information about the chat boost',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `chat_join_request`
--

CREATE TABLE `chat_join_request` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Unique identifier for this entry',
  `chat_id` bigint(20) NOT NULL COMMENT 'Chat to which the request was sent',
  `user_id` bigint(20) NOT NULL COMMENT 'User that sent the join request',
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Date the request was sent in Unix time',
  `bio` text DEFAULT NULL COMMENT 'Optional. Bio of the user',
  `invite_link` text DEFAULT NULL COMMENT 'Optional. Chat invite link that was used by the user to send the join request',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `chat_member_updated`
--

CREATE TABLE `chat_member_updated` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Unique identifier for this entry',
  `chat_id` bigint(20) NOT NULL COMMENT 'Chat the user belongs to',
  `user_id` bigint(20) NOT NULL COMMENT 'Performer of the action, which resulted in the change',
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Date the change was done in Unix time',
  `old_chat_member` text NOT NULL COMMENT 'Previous information about the chat member',
  `new_chat_member` text NOT NULL COMMENT 'New information about the chat member',
  `invite_link` text DEFAULT NULL COMMENT 'Chat invite link, which was used by the user to join the chat; for joining by invite link events only',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `chosen_inline_result`
--

CREATE TABLE `chosen_inline_result` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Unique identifier for this entry',
  `result_id` char(255) NOT NULL DEFAULT '' COMMENT 'The unique identifier for the result that was chosen',
  `user_id` bigint(20) DEFAULT NULL COMMENT 'The user that chose the result',
  `location` char(255) DEFAULT NULL COMMENT 'Sender location, only for bots that require user location',
  `inline_message_id` char(255) DEFAULT NULL COMMENT 'Identifier of the sent inline message',
  `query` text NOT NULL COMMENT 'The query that was used to obtain the result',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `conversation`
--

CREATE TABLE `conversation` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Unique identifier for this entry',
  `user_id` bigint(20) DEFAULT NULL COMMENT 'Unique user identifier',
  `chat_id` bigint(20) DEFAULT NULL COMMENT 'Unique user or chat identifier',
  `status` enum('active','cancelled','stopped') NOT NULL DEFAULT 'active' COMMENT 'Conversation state',
  `command` varchar(160) DEFAULT '' COMMENT 'Default command to execute',
  `notes` text DEFAULT NULL COMMENT 'Data stored from command',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date update'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `edited_message`
--

CREATE TABLE `edited_message` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Unique identifier for this entry',
  `chat_id` bigint(20) DEFAULT NULL COMMENT 'Unique chat identifier',
  `message_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'Unique message identifier',
  `user_id` bigint(20) DEFAULT NULL COMMENT 'Unique user identifier',
  `edit_date` timestamp NULL DEFAULT NULL COMMENT 'Date the message was edited in timestamp format',
  `text` text DEFAULT NULL COMMENT 'For text messages, the actual UTF-8 text of the message max message length 4096 char utf8',
  `entities` text DEFAULT NULL COMMENT 'For text messages, special entities like usernames, URLs, bot commands, etc. that appear in the text',
  `caption` text DEFAULT NULL COMMENT 'For message with caption, the actual UTF-8 text of the caption'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `inline_query`
--

CREATE TABLE `inline_query` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Unique identifier for this query',
  `user_id` bigint(20) DEFAULT NULL COMMENT 'Unique user identifier',
  `location` char(255) DEFAULT NULL COMMENT 'Location of the user',
  `query` text NOT NULL COMMENT 'Text of the query',
  `offset` char(255) DEFAULT NULL COMMENT 'Offset of the result',
  `chat_type` char(255) DEFAULT NULL COMMENT 'Optional. Type of the chat, from which the inline query was sent.',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `message`
--

CREATE TABLE `message` (
  `chat_id` bigint(20) NOT NULL COMMENT 'Unique chat identifier',
  `sender_chat_id` bigint(20) DEFAULT NULL COMMENT 'Sender of the message, sent on behalf of a chat',
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Unique message identifier',
  `message_thread_id` bigint(20) DEFAULT NULL COMMENT 'Unique identifier of a message thread to which the message belongs; for supergroups only',
  `user_id` bigint(20) DEFAULT NULL COMMENT 'Unique user identifier',
  `sender_boost_count` bigint(20) DEFAULT NULL COMMENT 'If the sender of the message boosted the chat, the number of boosts added by the user',
  `date` timestamp NULL DEFAULT NULL COMMENT 'Date the message was sent in timestamp format',
  `forward_from` bigint(20) DEFAULT NULL COMMENT 'Unique user identifier, sender of the original message',
  `forward_from_chat` bigint(20) DEFAULT NULL COMMENT 'Unique chat identifier, chat the original message belongs to',
  `forward_from_message_id` bigint(20) DEFAULT NULL COMMENT 'Unique chat identifier of the original message in the channel',
  `forward_signature` text DEFAULT NULL COMMENT 'For messages forwarded from channels, signature of the post author if present',
  `forward_sender_name` text DEFAULT NULL COMMENT 'Sender''s name for messages forwarded from users who disallow adding a link to their account in forwarded messages',
  `forward_date` timestamp NULL DEFAULT NULL COMMENT 'date the original message was sent in timestamp format',
  `is_topic_message` tinyint(1) DEFAULT 0 COMMENT 'True, if the message is sent to a forum topic',
  `is_automatic_forward` tinyint(1) DEFAULT 0 COMMENT 'True, if the message is a channel post that was automatically forwarded to the connected discussion group',
  `reply_to_chat` bigint(20) DEFAULT NULL COMMENT 'Unique chat identifier',
  `reply_to_message` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'Message that this message is reply to',
  `external_reply` text DEFAULT NULL COMMENT 'Optional. Information about the message that is being replied to, which may come from another chat or forum topic',
  `quote` text DEFAULT NULL COMMENT 'Optional. For replies that quote part of the original message, the quoted part of the message',
  `reply_to_story` text DEFAULT NULL COMMENT 'Optional. For replies to a story, the original story',
  `via_bot` bigint(20) DEFAULT NULL COMMENT 'Optional. Bot through which the message was sent',
  `link_preview_options` text DEFAULT NULL COMMENT 'Optional. Options used for link preview generation for the message, if it is a text message and link preview options were changed',
  `edit_date` timestamp NULL DEFAULT NULL COMMENT 'Date the message was last edited in Unix time',
  `has_protected_content` tinyint(1) DEFAULT 0 COMMENT 'True, if the message can''t be forwarded',
  `media_group_id` text DEFAULT NULL COMMENT 'The unique identifier of a media message group this message belongs to',
  `author_signature` text DEFAULT NULL COMMENT 'Signature of the post author for messages in channels',
  `text` text DEFAULT NULL COMMENT 'For text messages, the actual UTF-8 text of the message max message length 4096 char utf8mb4',
  `entities` text DEFAULT NULL COMMENT 'For text messages, special entities like usernames, URLs, bot commands, etc. that appear in the text',
  `caption_entities` text DEFAULT NULL COMMENT 'For messages with a caption, special entities like usernames, URLs, bot commands, etc. that appear in the caption',
  `audio` text DEFAULT NULL COMMENT 'Audio object. Message is an audio file, information about the file',
  `document` text DEFAULT NULL COMMENT 'Document object. Message is a general file, information about the file',
  `animation` text DEFAULT NULL COMMENT 'Message is an animation, information about the animation',
  `game` text DEFAULT NULL COMMENT 'Game object. Message is a game, information about the game',
  `photo` text DEFAULT NULL COMMENT 'Array of PhotoSize objects. Message is a photo, available sizes of the photo',
  `sticker` text DEFAULT NULL COMMENT 'Sticker object. Message is a sticker, information about the sticker',
  `story` text DEFAULT NULL COMMENT 'Story object. Message is a forwarded story',
  `video` text DEFAULT NULL COMMENT 'Video object. Message is a video, information about the video',
  `voice` text DEFAULT NULL COMMENT 'Voice Object. Message is a Voice, information about the Voice',
  `video_note` text DEFAULT NULL COMMENT 'VoiceNote Object. Message is a Video Note, information about the Video Note',
  `caption` text DEFAULT NULL COMMENT 'For message with caption, the actual UTF-8 text of the caption',
  `has_media_spoiler` tinyint(1) DEFAULT 0 COMMENT 'True, if the message media is covered by a spoiler animation',
  `contact` text DEFAULT NULL COMMENT 'Contact object. Message is a shared contact, information about the contact',
  `location` text DEFAULT NULL COMMENT 'Location object. Message is a shared location, information about the location',
  `venue` text DEFAULT NULL COMMENT 'Venue object. Message is a Venue, information about the Venue',
  `poll` text DEFAULT NULL COMMENT 'Poll object. Message is a native poll, information about the poll',
  `dice` text DEFAULT NULL COMMENT 'Message is a dice with random value from 1 to 6',
  `new_chat_members` text DEFAULT NULL COMMENT 'List of unique user identifiers, new member(s) were added to the group, information about them (one of these members may be the bot itself)',
  `left_chat_member` bigint(20) DEFAULT NULL COMMENT 'Unique user identifier, a member was removed from the group, information about them (this member may be the bot itself)',
  `new_chat_title` char(255) DEFAULT NULL COMMENT 'A chat title was changed to this value',
  `new_chat_photo` text DEFAULT NULL COMMENT 'Array of PhotoSize objects. A chat photo was change to this value',
  `delete_chat_photo` tinyint(1) DEFAULT 0 COMMENT 'Informs that the chat photo was deleted',
  `group_chat_created` tinyint(1) DEFAULT 0 COMMENT 'Informs that the group has been created',
  `supergroup_chat_created` tinyint(1) DEFAULT 0 COMMENT 'Informs that the supergroup has been created',
  `channel_chat_created` tinyint(1) DEFAULT 0 COMMENT 'Informs that the channel chat has been created',
  `message_auto_delete_timer_changed` text DEFAULT NULL COMMENT 'MessageAutoDeleteTimerChanged object. Message is a service message: auto-delete timer settings changed in the chat',
  `migrate_to_chat_id` bigint(20) DEFAULT NULL COMMENT 'Migrate to chat identifier. The group has been migrated to a supergroup with the specified identifier',
  `migrate_from_chat_id` bigint(20) DEFAULT NULL COMMENT 'Migrate from chat identifier. The supergroup has been migrated from a group with the specified identifier',
  `pinned_message` text DEFAULT NULL COMMENT 'Message object. Specified message was pinned',
  `invoice` text DEFAULT NULL COMMENT 'Message is an invoice for a payment, information about the invoice',
  `successful_payment` text DEFAULT NULL COMMENT 'Message is a service message about a successful payment, information about the payment',
  `users_shared` text DEFAULT NULL COMMENT 'Optional. Service message: users were shared with the bot',
  `chat_shared` text DEFAULT NULL COMMENT 'Optional. Service message: a chat was shared with the bot',
  `connected_website` text DEFAULT NULL COMMENT 'The domain name of the website on which the user has logged in.',
  `write_access_allowed` text DEFAULT NULL COMMENT 'Service message: the user allowed the bot added to the attachment menu to write messages',
  `passport_data` text DEFAULT NULL COMMENT 'Telegram Passport data',
  `proximity_alert_triggered` text DEFAULT NULL COMMENT 'Service message. A user in the chat triggered another user''s proximity alert while sharing Live Location.',
  `boost_added` text DEFAULT NULL COMMENT 'Service message: user boosted the chat',
  `forum_topic_created` text DEFAULT NULL COMMENT 'Service message: forum topic created',
  `forum_topic_edited` text DEFAULT NULL COMMENT 'Service message: forum topic edited',
  `forum_topic_closed` text DEFAULT NULL COMMENT 'Service message: forum topic closed',
  `forum_topic_reopened` text DEFAULT NULL COMMENT 'Service message: forum topic reopened',
  `general_forum_topic_hidden` text DEFAULT NULL COMMENT 'Service message: the General forum topic hidden',
  `general_forum_topic_unhidden` text DEFAULT NULL COMMENT 'Service message: the General forum topic unhidden',
  `video_chat_scheduled` text DEFAULT NULL COMMENT 'Service message: video chat scheduled',
  `video_chat_started` text DEFAULT NULL COMMENT 'Service message: video chat started',
  `video_chat_ended` text DEFAULT NULL COMMENT 'Service message: video chat ended',
  `video_chat_participants_invited` text DEFAULT NULL COMMENT 'Service message: new participants invited to a video chat',
  `web_app_data` text DEFAULT NULL COMMENT 'Service message: data sent by a Web App',
  `reply_markup` text DEFAULT NULL COMMENT 'Inline keyboard attached to the message'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `message_reaction`
--

CREATE TABLE `message_reaction` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Unique identifier for this entry',
  `chat_id` bigint(20) DEFAULT NULL COMMENT 'The chat containing the message the user reacted to',
  `message_id` bigint(20) DEFAULT NULL COMMENT 'Unique identifier of the message inside the chat',
  `user_id` bigint(20) DEFAULT NULL COMMENT 'Optional. The user that changed the reaction, if the user isn''t anonymous',
  `actor_chat_id` bigint(20) DEFAULT NULL COMMENT 'Optional. The chat on behalf of which the reaction was changed, if the user is anonymous',
  `old_reaction` text NOT NULL COMMENT 'Previous list of reaction types that were set by the user',
  `new_reaction` text NOT NULL COMMENT 'New list of reaction types that have been set by the user',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `message_reaction_count`
--

CREATE TABLE `message_reaction_count` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Unique identifier for this entry',
  `chat_id` bigint(20) DEFAULT NULL COMMENT 'The chat containing the message',
  `message_id` bigint(20) DEFAULT NULL COMMENT 'Unique message identifier inside the chat',
  `reactions` text NOT NULL COMMENT 'List of reactions that are present on the message',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `poll`
--

CREATE TABLE `poll` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Unique poll identifier',
  `question` text NOT NULL COMMENT 'Poll question',
  `options` text NOT NULL COMMENT 'List of poll options',
  `total_voter_count` int(10) UNSIGNED DEFAULT NULL COMMENT 'Total number of users that voted in the poll',
  `is_closed` tinyint(1) DEFAULT 0 COMMENT 'True, if the poll is closed',
  `is_anonymous` tinyint(1) DEFAULT 1 COMMENT 'True, if the poll is anonymous',
  `type` char(255) DEFAULT NULL COMMENT 'Poll type, currently can be “regular” or “quiz”',
  `allows_multiple_answers` tinyint(1) DEFAULT 0 COMMENT 'True, if the poll allows multiple answers',
  `correct_option_id` int(10) UNSIGNED DEFAULT NULL COMMENT '0-based identifier of the correct answer option. Available only for polls in the quiz mode, which are closed, or was sent (not forwarded) by the bot or to the private chat with the bot.',
  `explanation` varchar(255) DEFAULT NULL COMMENT 'Text that is shown when a user chooses an incorrect answer or taps on the lamp icon in a quiz-style poll, 0-200 characters',
  `explanation_entities` text DEFAULT NULL COMMENT 'Special entities like usernames, URLs, bot commands, etc. that appear in the explanation',
  `open_period` int(10) UNSIGNED DEFAULT NULL COMMENT 'Amount of time in seconds the poll will be active after creation',
  `close_date` timestamp NULL DEFAULT NULL COMMENT 'Point in time (Unix timestamp) when the poll will be automatically closed',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `poll_answer`
--

CREATE TABLE `poll_answer` (
  `poll_id` bigint(20) UNSIGNED NOT NULL COMMENT 'Unique poll identifier',
  `user_id` bigint(20) NOT NULL COMMENT 'The user, who changed the answer to the poll',
  `option_ids` text NOT NULL COMMENT '0-based identifiers of answer options, chosen by the user. May be empty if the user retracted their vote.',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `pre_checkout_query`
--

CREATE TABLE `pre_checkout_query` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Unique query identifier',
  `user_id` bigint(20) DEFAULT NULL COMMENT 'User who sent the query',
  `currency` char(3) DEFAULT NULL COMMENT 'Three-letter ISO 4217 currency code',
  `total_amount` bigint(20) DEFAULT NULL COMMENT 'Total price in the smallest units of the currency',
  `invoice_payload` char(255) NOT NULL DEFAULT '' COMMENT 'Bot specified invoice payload',
  `shipping_option_id` char(255) DEFAULT NULL COMMENT 'Identifier of the shipping option chosen by the user',
  `order_info` text DEFAULT NULL COMMENT 'Order info provided by the user',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `request_limiter`
--

CREATE TABLE `request_limiter` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Unique identifier for this entry',
  `chat_id` char(255) DEFAULT NULL COMMENT 'Unique chat identifier',
  `inline_message_id` char(255) DEFAULT NULL COMMENT 'Identifier of the sent inline message',
  `method` char(255) DEFAULT NULL COMMENT 'Request method',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `shipping_query`
--

CREATE TABLE `shipping_query` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Unique query identifier',
  `user_id` bigint(20) DEFAULT NULL COMMENT 'User who sent the query',
  `invoice_payload` char(255) NOT NULL DEFAULT '' COMMENT 'Bot specified invoice payload',
  `shipping_address` char(255) NOT NULL DEFAULT '' COMMENT 'User specified shipping address',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `telegram_update`
--

CREATE TABLE `telegram_update` (
  `id` bigint(20) UNSIGNED NOT NULL COMMENT 'Update''s unique identifier',
  `chat_id` bigint(20) DEFAULT NULL COMMENT 'Unique chat identifier',
  `message_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'New incoming message of any kind - text, photo, sticker, etc.',
  `edited_message_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'New version of a message that is known to the bot and was edited',
  `channel_post_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'New incoming channel post of any kind - text, photo, sticker, etc.',
  `edited_channel_post_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'New version of a channel post that is known to the bot and was edited',
  `message_reaction_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'A reaction to a message was changed by a user',
  `message_reaction_count_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'Reactions to a message with anonymous reactions were changed',
  `inline_query_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'New incoming inline query',
  `chosen_inline_result_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'The result of an inline query that was chosen by a user and sent to their chat partner',
  `callback_query_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'New incoming callback query',
  `shipping_query_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'New incoming shipping query. Only for invoices with flexible price',
  `pre_checkout_query_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'New incoming pre-checkout query. Contains full information about checkout',
  `poll_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'New poll state. Bots receive only updates about polls, which are sent or stopped by the bot',
  `poll_answer_poll_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'A user changed their answer in a non-anonymous poll. Bots receive new votes only in polls that were sent by the bot itself.',
  `my_chat_member_updated_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'The bot''s chat member status was updated in a chat. For private chats, this update is received only when the bot is blocked or unblocked by the user.',
  `chat_member_updated_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'A chat member''s status was updated in a chat. The bot must be an administrator in the chat and must explicitly specify “chat_member” in the list of allowed_updates to receive these updates.',
  `chat_join_request_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'A request to join the chat has been sent',
  `chat_boost_updated_id` bigint(20) UNSIGNED DEFAULT NULL,
  `chat_boost_removed_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `user`
--

CREATE TABLE `user` (
  `id` bigint(20) NOT NULL COMMENT 'Unique identifier for this user or bot',
  `is_bot` tinyint(1) DEFAULT 0 COMMENT 'True, if this user is a bot',
  `first_name` char(255) NOT NULL DEFAULT '' COMMENT 'User''s or bot''s first name',
  `last_name` char(255) DEFAULT NULL COMMENT 'User''s or bot''s last name',
  `username` char(191) DEFAULT NULL COMMENT 'User''s or bot''s username',
  `language_code` char(10) DEFAULT NULL COMMENT 'IETF language tag of the user''s language',
  `is_premium` tinyint(1) DEFAULT 0 COMMENT 'True, if this user is a Telegram Premium user',
  `added_to_attachment_menu` tinyint(1) DEFAULT 0 COMMENT 'True, if this user added the bot to the attachment menu',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date creation',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Entry date update'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `user_chat`
--

CREATE TABLE `user_chat` (
  `user_id` bigint(20) NOT NULL COMMENT 'Unique user identifier',
  `chat_id` bigint(20) NOT NULL COMMENT 'Unique user or chat identifier'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `user_data`
--

CREATE TABLE `user_data` (
  `id` int(11) NOT NULL,
  `chat_id` bigint(20) NOT NULL,
  `data` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `chat_boost_updated_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `callback_query`
--
ALTER TABLE `callback_query`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `chat_id` (`chat_id`),
  ADD KEY `message_id` (`message_id`),
  ADD KEY `chat_id_2` (`chat_id`,`message_id`);

--
-- Индексы таблицы `chat`
--
ALTER TABLE `chat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `old_id` (`old_id`);

--
-- Индексы таблицы `chat_boost_removed`
--
ALTER TABLE `chat_boost_removed`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chat_id` (`chat_id`);

--
-- Индексы таблицы `chat_boost_updated`
--
ALTER TABLE `chat_boost_updated`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chat_id` (`chat_id`);

--
-- Индексы таблицы `chat_join_request`
--
ALTER TABLE `chat_join_request`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chat_id` (`chat_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `chat_member_updated`
--
ALTER TABLE `chat_member_updated`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chat_id` (`chat_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `chosen_inline_result`
--
ALTER TABLE `chosen_inline_result`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `conversation`
--
ALTER TABLE `conversation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `chat_id` (`chat_id`),
  ADD KEY `status` (`status`);

--
-- Индексы таблицы `edited_message`
--
ALTER TABLE `edited_message`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chat_id` (`chat_id`),
  ADD KEY `message_id` (`message_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `chat_id_2` (`chat_id`,`message_id`);

--
-- Индексы таблицы `inline_query`
--
ALTER TABLE `inline_query`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`chat_id`,`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `forward_from` (`forward_from`),
  ADD KEY `forward_from_chat` (`forward_from_chat`),
  ADD KEY `reply_to_chat` (`reply_to_chat`),
  ADD KEY `reply_to_message` (`reply_to_message`),
  ADD KEY `via_bot` (`via_bot`),
  ADD KEY `left_chat_member` (`left_chat_member`),
  ADD KEY `migrate_from_chat_id` (`migrate_from_chat_id`),
  ADD KEY `migrate_to_chat_id` (`migrate_to_chat_id`),
  ADD KEY `reply_to_chat_2` (`reply_to_chat`,`reply_to_message`);

--
-- Индексы таблицы `message_reaction`
--
ALTER TABLE `message_reaction`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chat_id` (`chat_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `actor_chat_id` (`actor_chat_id`);

--
-- Индексы таблицы `message_reaction_count`
--
ALTER TABLE `message_reaction_count`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chat_id` (`chat_id`);

--
-- Индексы таблицы `poll`
--
ALTER TABLE `poll`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `poll_answer`
--
ALTER TABLE `poll_answer`
  ADD PRIMARY KEY (`poll_id`,`user_id`);

--
-- Индексы таблицы `pre_checkout_query`
--
ALTER TABLE `pre_checkout_query`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `request_limiter`
--
ALTER TABLE `request_limiter`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `shipping_query`
--
ALTER TABLE `shipping_query`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `telegram_update`
--
ALTER TABLE `telegram_update`
  ADD PRIMARY KEY (`id`),
  ADD KEY `message_id` (`message_id`),
  ADD KEY `chat_message_id` (`chat_id`,`message_id`),
  ADD KEY `edited_message_id` (`edited_message_id`),
  ADD KEY `channel_post_id` (`channel_post_id`),
  ADD KEY `edited_channel_post_id` (`edited_channel_post_id`),
  ADD KEY `inline_query_id` (`inline_query_id`),
  ADD KEY `chosen_inline_result_id` (`chosen_inline_result_id`),
  ADD KEY `callback_query_id` (`callback_query_id`),
  ADD KEY `shipping_query_id` (`shipping_query_id`),
  ADD KEY `pre_checkout_query_id` (`pre_checkout_query_id`),
  ADD KEY `poll_id` (`poll_id`),
  ADD KEY `poll_answer_poll_id` (`poll_answer_poll_id`),
  ADD KEY `my_chat_member_updated_id` (`my_chat_member_updated_id`),
  ADD KEY `chat_member_updated_id` (`chat_member_updated_id`),
  ADD KEY `chat_join_request_id` (`chat_join_request_id`),
  ADD KEY `chat_id` (`chat_id`,`channel_post_id`);

--
-- Индексы таблицы `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`);

--
-- Индексы таблицы `user_chat`
--
ALTER TABLE `user_chat`
  ADD PRIMARY KEY (`user_id`,`chat_id`),
  ADD KEY `chat_id` (`chat_id`);

--
-- Индексы таблицы `user_data`
--
ALTER TABLE `user_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_chat_boost` (`chat_boost_updated_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `chat_boost_removed`
--
ALTER TABLE `chat_boost_removed`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier for this entry';

--
-- AUTO_INCREMENT для таблицы `chat_boost_updated`
--
ALTER TABLE `chat_boost_updated`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier for this entry';

--
-- AUTO_INCREMENT для таблицы `chat_join_request`
--
ALTER TABLE `chat_join_request`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier for this entry';

--
-- AUTO_INCREMENT для таблицы `chat_member_updated`
--
ALTER TABLE `chat_member_updated`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier for this entry';

--
-- AUTO_INCREMENT для таблицы `chosen_inline_result`
--
ALTER TABLE `chosen_inline_result`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier for this entry';

--
-- AUTO_INCREMENT для таблицы `conversation`
--
ALTER TABLE `conversation`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier for this entry';

--
-- AUTO_INCREMENT для таблицы `edited_message`
--
ALTER TABLE `edited_message`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier for this entry';

--
-- AUTO_INCREMENT для таблицы `message_reaction`
--
ALTER TABLE `message_reaction`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier for this entry';

--
-- AUTO_INCREMENT для таблицы `message_reaction_count`
--
ALTER TABLE `message_reaction_count`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier for this entry';

--
-- AUTO_INCREMENT для таблицы `request_limiter`
--
ALTER TABLE `request_limiter`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier for this entry';

--
-- AUTO_INCREMENT для таблицы `user_data`
--
ALTER TABLE `user_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `callback_query`
--
ALTER TABLE `callback_query`
  ADD CONSTRAINT `callback_query_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `callback_query_ibfk_2` FOREIGN KEY (`chat_id`,`message_id`) REFERENCES `message` (`chat_id`, `id`);

--
-- Ограничения внешнего ключа таблицы `chat_boost_removed`
--
ALTER TABLE `chat_boost_removed`
  ADD CONSTRAINT `chat_boost_removed_ibfk_1` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`);

--
-- Ограничения внешнего ключа таблицы `chat_boost_updated`
--
ALTER TABLE `chat_boost_updated`
  ADD CONSTRAINT `chat_boost_updated_ibfk_1` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`);

--
-- Ограничения внешнего ключа таблицы `chat_join_request`
--
ALTER TABLE `chat_join_request`
  ADD CONSTRAINT `chat_join_request_ibfk_1` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`),
  ADD CONSTRAINT `chat_join_request_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Ограничения внешнего ключа таблицы `chat_member_updated`
--
ALTER TABLE `chat_member_updated`
  ADD CONSTRAINT `chat_member_updated_ibfk_1` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`),
  ADD CONSTRAINT `chat_member_updated_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Ограничения внешнего ключа таблицы `chosen_inline_result`
--
ALTER TABLE `chosen_inline_result`
  ADD CONSTRAINT `chosen_inline_result_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Ограничения внешнего ключа таблицы `conversation`
--
ALTER TABLE `conversation`
  ADD CONSTRAINT `conversation_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `conversation_ibfk_2` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`);

--
-- Ограничения внешнего ключа таблицы `edited_message`
--
ALTER TABLE `edited_message`
  ADD CONSTRAINT `edited_message_ibfk_1` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`),
  ADD CONSTRAINT `edited_message_ibfk_2` FOREIGN KEY (`chat_id`,`message_id`) REFERENCES `message` (`chat_id`, `id`),
  ADD CONSTRAINT `edited_message_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Ограничения внешнего ключа таблицы `inline_query`
--
ALTER TABLE `inline_query`
  ADD CONSTRAINT `inline_query_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Ограничения внешнего ключа таблицы `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `message_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `message_ibfk_2` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`),
  ADD CONSTRAINT `message_ibfk_3` FOREIGN KEY (`forward_from`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `message_ibfk_4` FOREIGN KEY (`forward_from_chat`) REFERENCES `chat` (`id`),
  ADD CONSTRAINT `message_ibfk_5` FOREIGN KEY (`reply_to_chat`,`reply_to_message`) REFERENCES `message` (`chat_id`, `id`),
  ADD CONSTRAINT `message_ibfk_6` FOREIGN KEY (`via_bot`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `message_ibfk_7` FOREIGN KEY (`left_chat_member`) REFERENCES `user` (`id`);

--
-- Ограничения внешнего ключа таблицы `message_reaction`
--
ALTER TABLE `message_reaction`
  ADD CONSTRAINT `message_reaction_ibfk_1` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`),
  ADD CONSTRAINT `message_reaction_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `message_reaction_ibfk_3` FOREIGN KEY (`actor_chat_id`) REFERENCES `chat` (`id`);

--
-- Ограничения внешнего ключа таблицы `message_reaction_count`
--
ALTER TABLE `message_reaction_count`
  ADD CONSTRAINT `message_reaction_count_ibfk_1` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`);

--
-- Ограничения внешнего ключа таблицы `poll_answer`
--
ALTER TABLE `poll_answer`
  ADD CONSTRAINT `poll_answer_ibfk_1` FOREIGN KEY (`poll_id`) REFERENCES `poll` (`id`);

--
-- Ограничения внешнего ключа таблицы `pre_checkout_query`
--
ALTER TABLE `pre_checkout_query`
  ADD CONSTRAINT `pre_checkout_query_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Ограничения внешнего ключа таблицы `shipping_query`
--
ALTER TABLE `shipping_query`
  ADD CONSTRAINT `shipping_query_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Ограничения внешнего ключа таблицы `telegram_update`
--
ALTER TABLE `telegram_update`
  ADD CONSTRAINT `telegram_update_ibfk_1` FOREIGN KEY (`chat_id`,`message_id`) REFERENCES `message` (`chat_id`, `id`),
  ADD CONSTRAINT `telegram_update_ibfk_10` FOREIGN KEY (`poll_id`) REFERENCES `poll` (`id`),
  ADD CONSTRAINT `telegram_update_ibfk_11` FOREIGN KEY (`poll_answer_poll_id`) REFERENCES `poll_answer` (`poll_id`),
  ADD CONSTRAINT `telegram_update_ibfk_12` FOREIGN KEY (`my_chat_member_updated_id`) REFERENCES `chat_member_updated` (`id`),
  ADD CONSTRAINT `telegram_update_ibfk_13` FOREIGN KEY (`chat_member_updated_id`) REFERENCES `chat_member_updated` (`id`),
  ADD CONSTRAINT `telegram_update_ibfk_14` FOREIGN KEY (`chat_join_request_id`) REFERENCES `chat_join_request` (`id`),
  ADD CONSTRAINT `telegram_update_ibfk_2` FOREIGN KEY (`edited_message_id`) REFERENCES `edited_message` (`id`),
  ADD CONSTRAINT `telegram_update_ibfk_3` FOREIGN KEY (`chat_id`,`channel_post_id`) REFERENCES `message` (`chat_id`, `id`),
  ADD CONSTRAINT `telegram_update_ibfk_4` FOREIGN KEY (`edited_channel_post_id`) REFERENCES `edited_message` (`id`),
  ADD CONSTRAINT `telegram_update_ibfk_5` FOREIGN KEY (`inline_query_id`) REFERENCES `inline_query` (`id`),
  ADD CONSTRAINT `telegram_update_ibfk_6` FOREIGN KEY (`chosen_inline_result_id`) REFERENCES `chosen_inline_result` (`id`),
  ADD CONSTRAINT `telegram_update_ibfk_7` FOREIGN KEY (`callback_query_id`) REFERENCES `callback_query` (`id`),
  ADD CONSTRAINT `telegram_update_ibfk_8` FOREIGN KEY (`shipping_query_id`) REFERENCES `shipping_query` (`id`),
  ADD CONSTRAINT `telegram_update_ibfk_9` FOREIGN KEY (`pre_checkout_query_id`) REFERENCES `pre_checkout_query` (`id`);

--
-- Ограничения внешнего ключа таблицы `user_chat`
--
ALTER TABLE `user_chat`
  ADD CONSTRAINT `user_chat_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_chat_ibfk_2` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `user_data`
--
ALTER TABLE `user_data`
  ADD CONSTRAINT `fk_chat_boost` FOREIGN KEY (`chat_boost_updated_id`) REFERENCES `chat_boost_updated` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
