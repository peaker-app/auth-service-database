CREATE TABLE IF NOT EXISTS `__EFMigrationsHistory` (
    `MigrationId` varchar(150) NOT NULL,
    `ProductVersion` varchar(32) NOT NULL,
    PRIMARY KEY (`MigrationId`)
);

START TRANSACTION;
IF NOT EXISTS(SELECT * FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20260723142455_InitialAuthSchema')
BEGIN
    CREATE TABLE `outbox_messages` (
        `id` char(36) NOT NULL,
        `type` varchar(500) NOT NULL,
        `content` longtext NOT NULL,
        `occurred_at_utc` datetime(6) NOT NULL,
        `processed_at_utc` datetime(6) NULL,
        `error` longtext NULL,
        PRIMARY KEY (`id`)
    );
END;

IF NOT EXISTS(SELECT * FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20260723142455_InitialAuthSchema')
BEGIN
    CREATE TABLE `processed_messages` (
        `message_id` char(36) NOT NULL,
        `processed_at_utc` datetime(6) NOT NULL,
        PRIMARY KEY (`message_id`)
    );
END;

IF NOT EXISTS(SELECT * FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20260723142455_InitialAuthSchema')
BEGIN
    CREATE TABLE `refresh_tokens` (
        `id` char(36) NOT NULL,
        `user_id` char(36) NOT NULL,
        `token_hash` varchar(255) NOT NULL,
        `expires_at_utc` datetime(6) NOT NULL,
        `revoked_at_utc` datetime(6) NULL,
        `replaced_by_id` char(36) NULL,
        `created_by_ip` varchar(45) NULL,
        `created_at_utc` datetime(6) NOT NULL,
        `updated_at_utc` datetime(6) NOT NULL,
        PRIMARY KEY (`id`)
    );
END;

IF NOT EXISTS(SELECT * FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20260723142455_InitialAuthSchema')
BEGIN
    CREATE TABLE `users` (
        `id` char(36) NOT NULL,
        `email` varchar(320) NOT NULL,
        `password_hash` varchar(255) NULL,
        `email_confirmed` tinyint(1) NOT NULL,
        `status` varchar(20) NOT NULL,
        `failed_login_count` int NOT NULL,
        `locked_until_utc` datetime(6) NULL,
        `created_at_utc` datetime(6) NOT NULL,
        `updated_at_utc` datetime(6) NOT NULL,
        PRIMARY KEY (`id`)
    );
END;

IF NOT EXISTS(SELECT * FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20260723142455_InitialAuthSchema')
BEGIN
    CREATE INDEX `ix_outbox_messages_processed_at_utc` ON `outbox_messages` (`processed_at_utc`);
END;

IF NOT EXISTS(SELECT * FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20260723142455_InitialAuthSchema')
BEGIN
    CREATE INDEX `ix_refresh_tokens_user_id` ON `refresh_tokens` (`user_id`);
END;

IF NOT EXISTS(SELECT * FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20260723142455_InitialAuthSchema')
BEGIN
    CREATE UNIQUE INDEX `ux_refresh_tokens_token_hash` ON `refresh_tokens` (`token_hash`);
END;

IF NOT EXISTS(SELECT * FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20260723142455_InitialAuthSchema')
BEGIN
    CREATE UNIQUE INDEX `ux_users_email` ON `users` (`email`);
END;

IF NOT EXISTS(SELECT * FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20260723142455_InitialAuthSchema')
BEGIN
    INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
    VALUES ('20260723142455_InitialAuthSchema', '10.0.10');
END;

COMMIT;

