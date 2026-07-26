START TRANSACTION;
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

COMMIT;

