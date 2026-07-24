START TRANSACTION;
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

COMMIT;

