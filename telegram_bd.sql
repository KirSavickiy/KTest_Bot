-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Июл 26 2024 г., 14:51
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

--
-- Дамп данных таблицы `chat`
--

INSERT INTO `chat` (`id`, `type`, `title`, `username`, `first_name`, `last_name`, `is_forum`, `all_members_are_administrators`, `created_at`, `updated_at`, `old_id`, `chat_boost_updated_id`) VALUES
(331207592, 'private', NULL, 'kirylsav', 'Kirill', 'Sawitskiy', NULL, 0, '2024-07-22 10:31:59', '2024-07-23 12:19:57', NULL, NULL);

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

--
-- Дамп данных таблицы `message`
--

INSERT INTO `message` (`chat_id`, `sender_chat_id`, `id`, `message_thread_id`, `user_id`, `sender_boost_count`, `date`, `forward_from`, `forward_from_chat`, `forward_from_message_id`, `forward_signature`, `forward_sender_name`, `forward_date`, `is_topic_message`, `is_automatic_forward`, `reply_to_chat`, `reply_to_message`, `external_reply`, `quote`, `reply_to_story`, `via_bot`, `link_preview_options`, `edit_date`, `has_protected_content`, `media_group_id`, `author_signature`, `text`, `entities`, `caption_entities`, `audio`, `document`, `animation`, `game`, `photo`, `sticker`, `story`, `video`, `voice`, `video_note`, `caption`, `has_media_spoiler`, `contact`, `location`, `venue`, `poll`, `dice`, `new_chat_members`, `left_chat_member`, `new_chat_title`, `new_chat_photo`, `delete_chat_photo`, `group_chat_created`, `supergroup_chat_created`, `channel_chat_created`, `message_auto_delete_timer_changed`, `migrate_to_chat_id`, `migrate_from_chat_id`, `pinned_message`, `invoice`, `successful_payment`, `users_shared`, `chat_shared`, `connected_website`, `write_access_allowed`, `passport_data`, `proximity_alert_triggered`, `boost_added`, `forum_topic_created`, `forum_topic_edited`, `forum_topic_closed`, `forum_topic_reopened`, `general_forum_topic_hidden`, `general_forum_topic_unhidden`, `video_chat_scheduled`, `video_chat_started`, `video_chat_ended`, `video_chat_participants_invited`, `web_app_data`, `reply_markup`) VALUES
(331207592, NULL, 212, NULL, 331207592, NULL, '2024-07-22 10:31:59', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-22 11:12:12', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 237, NULL, 331207592, NULL, '2024-07-22 11:50:50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-22 11:50:54', 0, NULL, NULL, '100', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 239, NULL, 331207592, NULL, '2024-07-22 11:51:04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-22 11:51:10', 0, NULL, NULL, '98', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 241, NULL, 331207592, NULL, '2024-07-22 11:51:19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-22 11:51:22', 0, NULL, NULL, '153', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 243, NULL, 331207592, NULL, '2024-07-22 11:53:22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-22 11:53:26', 0, NULL, NULL, '153', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 245, NULL, 331207592, NULL, '2024-07-22 11:53:33', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-22 11:53:39', 0, NULL, NULL, '98', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 247, NULL, 331207592, NULL, '2024-07-22 11:57:31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-22 11:57:37', 0, NULL, NULL, '88', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 249, NULL, 331207592, NULL, '2024-07-22 11:57:59', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-22 11:58:07', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 252, NULL, 331207592, NULL, '2024-07-22 11:59:41', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-22 11:59:50', 0, NULL, NULL, '6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 253, NULL, 331207592, NULL, '2024-07-22 11:59:47', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-22 11:59:50', 0, NULL, NULL, '4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 255, NULL, 331207592, NULL, '2024-07-22 11:59:54', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-22 12:00:03', 0, NULL, NULL, '545', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 257, NULL, 331207592, NULL, '2024-07-22 12:03:07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-22 12:03:10', 0, NULL, NULL, '6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 259, NULL, 331207592, NULL, '2024-07-22 12:04:09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-22 12:04:14', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 262, NULL, 331207592, NULL, '2024-07-22 12:04:19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-22 12:04:22', 0, NULL, NULL, '100', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 264, NULL, 331207592, NULL, '2024-07-22 13:54:05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 06:03:58', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 267, NULL, 331207592, NULL, '2024-07-23 06:21:46', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 06:21:55', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 270, NULL, 331207592, NULL, '2024-07-23 06:23:32', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 06:23:40', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 273, NULL, 331207592, NULL, '2024-07-23 06:34:21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 06:34:29', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 276, NULL, 331207592, NULL, '2024-07-23 06:34:50', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 06:34:57', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 279, NULL, 331207592, NULL, '2024-07-23 06:38:05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 06:38:15', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 281, NULL, 331207592, NULL, '2024-07-23 06:38:22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 06:38:30', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 283, NULL, 331207592, NULL, '2024-07-23 06:59:55', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 07:00:06', 0, NULL, NULL, '342344', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 284, NULL, 331207592, NULL, '2024-07-23 06:59:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 07:00:06', 0, NULL, NULL, '3r23r', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 285, NULL, 331207592, NULL, '2024-07-23 06:59:58', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 07:00:06', 0, NULL, NULL, '323424', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 287, NULL, 331207592, NULL, '2024-07-23 07:00:11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 07:00:19', 0, NULL, NULL, '18', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 289, NULL, 331207592, NULL, '2024-07-23 07:00:36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 07:00:43', 0, NULL, NULL, '3432432', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 290, NULL, 331207592, NULL, '2024-07-23 07:00:38', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 07:00:43', 0, NULL, NULL, '43424', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 292, NULL, 331207592, NULL, '2024-07-23 07:01:19', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 07:01:29', 0, NULL, NULL, '123123v efwefwef', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 293, NULL, 331207592, NULL, '2024-07-23 07:10:30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 07:10:36', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 294, NULL, 331207592, NULL, '2024-07-23 07:11:08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 07:11:19', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 295, NULL, 331207592, NULL, '2024-07-23 07:12:06', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 07:12:14', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 296, NULL, 331207592, NULL, '2024-07-23 07:13:07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 07:13:35', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 298, NULL, 331207592, NULL, '2024-07-23 07:28:09', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 07:28:12', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 300, NULL, 331207592, NULL, '2024-07-23 07:28:30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 07:28:35', 0, NULL, NULL, '1539', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 301, NULL, 331207592, NULL, '2024-07-23 07:28:53', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 07:28:58', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 303, NULL, 331207592, NULL, '2024-07-23 07:29:16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 07:29:22', 0, NULL, NULL, '32', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 304, NULL, 331207592, NULL, '2024-07-23 07:32:12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 07:32:18', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 306, NULL, 331207592, NULL, '2024-07-23 07:32:23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 07:32:28', 0, NULL, NULL, '34234', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 307, NULL, 331207592, NULL, '2024-07-23 07:34:42', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 07:34:48', 0, NULL, NULL, '3434', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 309, NULL, 331207592, NULL, '2024-07-23 07:34:59', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 07:35:03', 0, NULL, NULL, '396', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 311, NULL, 331207592, NULL, '2024-07-23 07:38:49', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 07:38:57', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 313, NULL, 331207592, NULL, '2024-07-23 07:39:07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 07:39:13', 0, NULL, NULL, '465', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 314, NULL, 331207592, NULL, '2024-07-23 07:42:41', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 07:43:07', 0, NULL, NULL, '465', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 315, NULL, 331207592, NULL, '2024-07-23 07:42:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 07:43:07', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 317, NULL, 331207592, NULL, '2024-07-23 07:43:11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 07:43:16', 0, NULL, NULL, '45', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 318, NULL, 331207592, NULL, '2024-07-23 07:46:29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 07:46:45', 0, NULL, NULL, '45', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 319, NULL, 331207592, NULL, '2024-07-23 07:46:40', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 07:46:45', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 321, NULL, 331207592, NULL, '2024-07-23 07:46:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 07:47:02', 0, NULL, NULL, '2700', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 322, NULL, 331207592, NULL, '2024-07-23 07:48:52', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 07:48:58', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 324, NULL, 331207592, NULL, '2024-07-23 07:53:03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 07:53:09', 0, NULL, NULL, '65', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 325, NULL, 331207592, NULL, '2024-07-23 07:55:07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 07:55:12', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 327, NULL, 331207592, NULL, '2024-07-23 07:55:20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 07:55:25', 0, NULL, NULL, '6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 328, NULL, 331207592, NULL, '2024-07-23 07:57:35', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 07:57:36', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 330, NULL, 331207592, NULL, '2024-07-23 07:57:46', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 07:57:52', 0, NULL, NULL, '292', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 331, NULL, 331207592, NULL, '2024-07-23 08:01:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 08:02:07', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 333, NULL, 331207592, NULL, '2024-07-23 08:02:17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 08:02:24', 0, NULL, NULL, '104', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 334, NULL, 331207592, NULL, '2024-07-23 08:07:51', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 08:07:58', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 336, NULL, 331207592, NULL, '2024-07-23 08:08:07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 08:08:13', 0, NULL, NULL, '7', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 337, NULL, 331207592, NULL, '2024-07-23 08:09:20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 08:09:26', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 339, NULL, 331207592, NULL, '2024-07-23 08:09:31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 08:09:36', 0, NULL, NULL, '14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 341, NULL, 331207592, NULL, '2024-07-23 08:11:47', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 08:12:02', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 343, NULL, 331207592, NULL, '2024-07-23 08:12:13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 08:12:17', 0, NULL, NULL, '43', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 344, NULL, 331207592, NULL, '2024-07-23 08:13:02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 08:13:11', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 346, NULL, 331207592, NULL, '2024-07-23 08:13:16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 08:13:27', 0, NULL, NULL, '99', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 348, NULL, 331207592, NULL, '2024-07-23 08:21:12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 08:21:25', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 350, NULL, 331207592, NULL, '2024-07-23 08:21:35', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 08:21:43', 0, NULL, NULL, '357', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 351, NULL, 331207592, NULL, '2024-07-23 08:22:25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 08:22:36', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 353, NULL, 331207592, NULL, '2024-07-23 08:22:41', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 08:22:53', 0, NULL, NULL, '57', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 354, NULL, 331207592, NULL, '2024-07-23 08:24:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 08:24:20', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 356, NULL, 331207592, NULL, '2024-07-23 08:24:24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 08:24:29', 0, NULL, NULL, '22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 357, NULL, 331207592, NULL, '2024-07-23 08:27:01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 08:27:10', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 359, NULL, 331207592, NULL, '2024-07-23 08:27:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 08:27:20', 0, NULL, NULL, '31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 361, NULL, 331207592, NULL, '2024-07-23 11:44:03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 11:44:07', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 362, NULL, 331207592, NULL, '2024-07-23 11:48:49', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 11:48:53', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 363, NULL, 331207592, NULL, '2024-07-23 11:49:17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 11:49:21', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 364, NULL, 331207592, NULL, '2024-07-23 11:51:53', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 11:51:56', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 366, NULL, 331207592, NULL, '2024-07-23 12:10:38', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 12:10:41', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 368, NULL, 331207592, NULL, '2024-07-23 12:12:55', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 12:12:59', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 370, NULL, 331207592, NULL, '2024-07-23 12:13:43', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 12:13:48', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 372, NULL, 331207592, NULL, '2024-07-23 12:13:53', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 12:13:59', 0, NULL, NULL, 'efwef', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 373, NULL, 331207592, NULL, '2024-07-23 12:15:02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 12:15:10', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 375, NULL, 331207592, NULL, '2024-07-23 12:15:13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 12:15:17', 0, NULL, NULL, '34324', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 376, NULL, 331207592, NULL, '2024-07-23 12:17:44', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 12:17:50', 0, NULL, NULL, '22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 378, NULL, 331207592, NULL, '2024-07-23 12:19:29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 12:19:33', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 380, NULL, 331207592, NULL, '2024-07-23 12:19:45', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 12:19:48', 0, NULL, NULL, '146', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 382, NULL, 331207592, NULL, '2024-07-23 12:19:51', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 12:19:54', 0, NULL, NULL, '/start', '[{\"offset\":0,\"length\":6,\"type\":\"bot_command\"}]', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(331207592, NULL, 384, NULL, 331207592, NULL, '2024-07-23 12:19:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-23 12:20:01', 0, NULL, NULL, 'fefwef', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

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

--
-- Дамп данных таблицы `telegram_update`
--

INSERT INTO `telegram_update` (`id`, `chat_id`, `message_id`, `edited_message_id`, `channel_post_id`, `edited_channel_post_id`, `message_reaction_id`, `message_reaction_count_id`, `inline_query_id`, `chosen_inline_result_id`, `callback_query_id`, `shipping_query_id`, `pre_checkout_query_id`, `poll_id`, `poll_answer_poll_id`, `my_chat_member_updated_id`, `chat_member_updated_id`, `chat_join_request_id`, `chat_boost_updated_id`, `chat_boost_removed_id`) VALUES
(592133468, 331207592, 212, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133469, 331207592, 237, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133470, 331207592, 239, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133471, 331207592, 241, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133472, 331207592, 243, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133473, 331207592, 245, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133474, 331207592, 247, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133475, 331207592, 249, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133476, 331207592, 252, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133477, 331207592, 253, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133478, 331207592, 255, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133479, 331207592, 257, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133480, 331207592, 259, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133481, 331207592, 262, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133482, 331207592, 264, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133483, 331207592, 267, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133484, 331207592, 270, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133485, 331207592, 273, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133486, 331207592, 276, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133487, 331207592, 279, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133488, 331207592, 281, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133489, 331207592, 283, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133490, 331207592, 284, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133491, 331207592, 285, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133492, 331207592, 287, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133493, 331207592, 289, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133494, 331207592, 290, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133495, 331207592, 292, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133496, 331207592, 293, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133497, 331207592, 294, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133498, 331207592, 295, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133499, 331207592, 296, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133500, 331207592, 298, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133501, 331207592, 300, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133502, 331207592, 301, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133503, 331207592, 303, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133504, 331207592, 304, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133505, 331207592, 306, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133506, 331207592, 307, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133507, 331207592, 309, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133508, 331207592, 311, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133509, 331207592, 313, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133510, 331207592, 314, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133511, 331207592, 315, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133512, 331207592, 317, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133513, 331207592, 318, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133514, 331207592, 319, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133515, 331207592, 321, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133516, 331207592, 322, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133517, 331207592, 324, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133518, 331207592, 325, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133519, 331207592, 327, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133520, 331207592, 328, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133521, 331207592, 330, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133522, 331207592, 331, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133523, 331207592, 333, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133524, 331207592, 334, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133525, 331207592, 336, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133526, 331207592, 337, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133527, 331207592, 339, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133528, 331207592, 341, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133529, 331207592, 343, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133530, 331207592, 344, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133531, 331207592, 346, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133532, 331207592, 348, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133533, 331207592, 350, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133534, 331207592, 351, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133535, 331207592, 353, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133536, 331207592, 354, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133537, 331207592, 356, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133538, 331207592, 357, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133539, 331207592, 359, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133540, 331207592, 361, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133541, 331207592, 362, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133542, 331207592, 363, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133543, 331207592, 364, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133544, 331207592, 366, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133545, 331207592, 368, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133546, 331207592, 370, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133547, 331207592, 372, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133548, 331207592, 373, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133549, 331207592, 375, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133550, 331207592, 376, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133551, 331207592, 378, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133552, 331207592, 380, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133553, 331207592, 382, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(592133554, 331207592, 384, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

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

--
-- Дамп данных таблицы `user`
--

INSERT INTO `user` (`id`, `is_bot`, `first_name`, `last_name`, `username`, `language_code`, `is_premium`, `added_to_attachment_menu`, `created_at`, `updated_at`) VALUES
(331207592, 0, 'Kirill', 'Sawitskiy', 'kirylsav', 'en', NULL, NULL, '2024-07-22 10:31:59', '2024-07-23 12:19:57');

-- --------------------------------------------------------

--
-- Структура таблицы `user_chat`
--

CREATE TABLE `user_chat` (
  `user_id` bigint(20) NOT NULL COMMENT 'Unique user identifier',
  `chat_id` bigint(20) NOT NULL COMMENT 'Unique user or chat identifier'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Дамп данных таблицы `user_chat`
--

INSERT INTO `user_chat` (`user_id`, `chat_id`) VALUES
(331207592, 331207592);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

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
