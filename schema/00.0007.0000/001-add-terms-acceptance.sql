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

IF NOT EXISTS(SELECT * FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20260723215222_AddUserUsername')
BEGIN
    ALTER TABLE `users` ADD `username` varchar(30) NOT NULL DEFAULT '';
END;

IF NOT EXISTS(SELECT * FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20260723215222_AddUserUsername')
BEGIN
    CREATE UNIQUE INDEX `ux_users_username` ON `users` (`username`);
END;

IF NOT EXISTS(SELECT * FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20260723215222_AddUserUsername')
BEGIN
    INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
    VALUES ('20260723215222_AddUserUsername', '10.0.10');
END;

IF NOT EXISTS(SELECT * FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20260725141259_AddEmailConfirmationTokens')
BEGIN
    CREATE TABLE `email_confirmation_tokens` (
        `id` char(36) NOT NULL,
        `user_id` char(36) NOT NULL,
        `token_hash` varchar(255) NOT NULL,
        `issued_at_utc` datetime(6) NOT NULL,
        `expires_at_utc` datetime(6) NOT NULL,
        `consumed_at_utc` datetime(6) NULL,
        `created_at_utc` datetime(6) NOT NULL,
        `updated_at_utc` datetime(6) NOT NULL,
        PRIMARY KEY (`id`)
    );
END;

IF NOT EXISTS(SELECT * FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20260725141259_AddEmailConfirmationTokens')
BEGIN
    CREATE INDEX `ix_email_confirmation_tokens_user_issued` ON `email_confirmation_tokens` (`user_id`, `issued_at_utc`);
END;

IF NOT EXISTS(SELECT * FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20260725141259_AddEmailConfirmationTokens')
BEGIN
    CREATE UNIQUE INDEX `ux_email_confirmation_tokens_token_hash` ON `email_confirmation_tokens` (`token_hash`);
END;

IF NOT EXISTS(SELECT * FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20260725141259_AddEmailConfirmationTokens')
BEGIN
    INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
    VALUES ('20260725141259_AddEmailConfirmationTokens', '10.0.10');
END;

IF NOT EXISTS(SELECT * FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20260810131242_AddEmailDispatchLog')
BEGIN
    CREATE TABLE `email_dispatch_log` (
        `id` char(36) NOT NULL,
        `recipient_hash` varchar(64) NOT NULL,
        `sent_at_utc` datetime(6) NOT NULL,
        PRIMARY KEY (`id`)
    );
END;

IF NOT EXISTS(SELECT * FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20260810131242_AddEmailDispatchLog')
BEGIN
    CREATE INDEX `ix_email_dispatch_recipient_sent` ON `email_dispatch_log` (`recipient_hash`, `sent_at_utc`);
END;

IF NOT EXISTS(SELECT * FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20260810131242_AddEmailDispatchLog')
BEGIN
    CREATE INDEX `ix_email_dispatch_sent` ON `email_dispatch_log` (`sent_at_utc`);
END;

IF NOT EXISTS(SELECT * FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20260810131242_AddEmailDispatchLog')
BEGIN
    INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
    VALUES ('20260810131242_AddEmailDispatchLog', '10.0.10');
END;

IF NOT EXISTS(SELECT * FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20260810205918_AddUserRoles')
BEGIN
    CREATE TABLE `user_roles` (
        `role` varchar(20) NOT NULL,
        `user_id` char(36) NOT NULL,
        PRIMARY KEY (`user_id`, `role`),
        CONSTRAINT `FK_user_roles_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
    );
END;

IF NOT EXISTS(SELECT * FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20260810205918_AddUserRoles')
BEGIN
    INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
    VALUES ('20260810205918_AddUserRoles', '10.0.10');
END;

IF NOT EXISTS(SELECT * FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20260810220004_AddPasswordResetsAndLoginThrottle')
BEGIN
    ALTER TABLE `users` DROP COLUMN `failed_login_count`;
END;

IF NOT EXISTS(SELECT * FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20260810220004_AddPasswordResetsAndLoginThrottle')
BEGIN
    ALTER TABLE `users` DROP COLUMN `locked_until_utc`;
END;

IF NOT EXISTS(SELECT * FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20260810220004_AddPasswordResetsAndLoginThrottle')
BEGIN
    CREATE TABLE `login_attempts` (
        `id` char(36) NOT NULL,
        `identifier_hash` varchar(64) NOT NULL,
        `ip_hash` varchar(64) NOT NULL,
        `attempted_at_utc` datetime(6) NOT NULL,
        PRIMARY KEY (`id`)
    );
END;

IF NOT EXISTS(SELECT * FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20260810220004_AddPasswordResetsAndLoginThrottle')
BEGIN
    CREATE TABLE `password_reset_tokens` (
        `id` char(36) NOT NULL,
        `user_id` char(36) NOT NULL,
        `token_hash` varchar(255) NOT NULL,
        `issued_at_utc` datetime(6) NOT NULL,
        `expires_at_utc` datetime(6) NOT NULL,
        `consumed_at_utc` datetime(6) NULL,
        `created_at_utc` datetime(6) NOT NULL,
        `updated_at_utc` datetime(6) NOT NULL,
        PRIMARY KEY (`id`)
    );
END;

IF NOT EXISTS(SELECT * FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20260810220004_AddPasswordResetsAndLoginThrottle')
BEGIN
    CREATE INDEX `ix_login_attempts_identifier_ip_time` ON `login_attempts` (`identifier_hash`, `ip_hash`, `attempted_at_utc`);
END;

IF NOT EXISTS(SELECT * FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20260810220004_AddPasswordResetsAndLoginThrottle')
BEGIN
    CREATE INDEX `ix_password_reset_tokens_user_issued` ON `password_reset_tokens` (`user_id`, `issued_at_utc`);
END;

IF NOT EXISTS(SELECT * FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20260810220004_AddPasswordResetsAndLoginThrottle')
BEGIN
    CREATE UNIQUE INDEX `ux_password_reset_tokens_token_hash` ON `password_reset_tokens` (`token_hash`);
END;

IF NOT EXISTS(SELECT * FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20260810220004_AddPasswordResetsAndLoginThrottle')
BEGIN
    INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
    VALUES ('20260810220004_AddPasswordResetsAndLoginThrottle', '10.0.10');
END;

IF NOT EXISTS(SELECT * FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20260811132431_AddTermsAcceptance')
BEGIN
    ALTER TABLE `users` ADD `terms_accepted_at_utc` datetime(6) NOT NULL DEFAULT '0001-01-01 00:00:00.000000';
END;

IF NOT EXISTS(SELECT * FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20260811132431_AddTermsAcceptance')
BEGIN
    ALTER TABLE `users` ADD `terms_version` varchar(20) NOT NULL DEFAULT '';
END;

IF NOT EXISTS(SELECT * FROM `__EFMigrationsHistory` WHERE `MigrationId` = '20260811132431_AddTermsAcceptance')
BEGIN
    INSERT INTO `__EFMigrationsHistory` (`MigrationId`, `ProductVersion`)
    VALUES ('20260811132431_AddTermsAcceptance', '10.0.10');
END;

COMMIT;

