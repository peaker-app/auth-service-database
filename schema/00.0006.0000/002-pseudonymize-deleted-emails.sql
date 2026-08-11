-- RGPD · Seudonimiza el correo de las cuentas dadas de baja antes de esta version.
--
-- A partir de 00.0006.0000, User.Delete sustituye el correo por su seudonimo en la misma
-- transaccion que la baja. Este script cubre a las filas que ya estaban en Deleted con el correo
-- en claro; no es una migracion de esquema ni un seed, sino reparacion de datos (DEVELOPMENT.md §8).
--
-- Debe replicar exactamente la regla de EmailPseudonymizer:
--   deleted+<sha256 hex del correo en mayusculas>@peaker.invalid, todo en minusculas
-- SHA2() de MySQL devuelve hex en minusculas y Email.Create normaliza a minusculas, asi que
-- el valor que escribe este script y el que escribe el codigo coinciden byte a byte.
--
-- Es reejecutable: el LIKE excluye las filas ya seudonimizadas.

START TRANSACTION;

UPDATE `users`
SET `email` = CONCAT('deleted+', SHA2(UPPER(`email`), 256), '@peaker.invalid')
WHERE `status` = 'Deleted'
  AND `email` NOT LIKE 'deleted+%@peaker.invalid';

COMMIT;
