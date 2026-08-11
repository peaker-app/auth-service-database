-- Concede el rol de administrador a una cuenta existente.
-- No hay auto-servicio para el primer administrador: se ejecuta a mano contra la base de datos,
-- sustituyendo el correo del marcador. A partir de ahi, un administrador concede el rol a otros
-- mediante POST /api/admin/users/{userId}/roles.
--
-- Reejecutable: si la cuenta ya tiene el rol, no hace nada.

START TRANSACTION;

INSERT INTO `user_roles` (`user_id`, `role`)
SELECT `id`, 'Admin'
FROM `users`
WHERE `email` = '<correo-del-administrador>'
  AND `status` = 'Active'
ON DUPLICATE KEY UPDATE `role` = `user_roles`.`role`;

COMMIT;
