CREATE SEQUENCE IF NOT EXISTS users_id_seq
	AS BIGINT
	MINVALUE 1
	MAXVALUE 9223372036854775807
	INCREMENT 1
	START 1;
	
CREATE TABLE IF NOT EXISTS users (
	id BIGINT NOT NULL DEFAULT nextval('users_id_seq') PRIMARY KEY,
	user_name varchar(15) NOT NULL,
	password varchar(255) NOT NULL,
	email varchar(255) NOT NULL
);

SELECT execute_operation_on_column('
   ALTER TABLE users DROP COLUMN IF EXISTS user_name;
');

SELECT execute_operation_on_column('
   ALTER TABLE users ADD COLUMN IF NOT EXISTS username varchar(15) NOT NULL;
');

