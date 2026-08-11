-- RGPD · Marca como «sin constancia» la aceptacion de condiciones de las cuentas anteriores.
--
-- La migracion 001 anade terms_version y terms_accepted_at_utc como NOT NULL, y a las filas ya
-- existentes les deja la cadena vacia y el ano 1. Eso no es una aceptacion: es la ausencia de una.
-- Este script lo hace explicito con el valor 'unrecorded' para que sea consultable.
--
-- El art. 7.1 del RGPD exige poder demostrar la aceptacion. Para estas cuentas no se puede, asi que
-- hay que volver a pedirsela cuando se publiquen las condiciones definitivas:
--   SELECT id, email FROM users WHERE terms_version = 'unrecorded';
--
-- Es reejecutable: solo toca las filas que aun tienen la cadena vacia.

START TRANSACTION;

UPDATE `users`
SET `terms_version` = 'unrecorded'
WHERE `terms_version` = '';

COMMIT;
