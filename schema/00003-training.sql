-- e.g Running, Weightlifting
CREATE SEQUENCE IF NOT EXISTS training_category_id_seq
	AS BIGINT
	MINVALUE 1
	MAXVALUE 9223372036854775807
	INCREMENT 1
	START 1;

CREATE TABLE IF NOT EXISTS training_category (
	id BIGINT NOT NULL DEFAULT nextval('training_category_id_seq') PRIMARY KEY,
	name varchar(255) NOT NULL,
	description varchar(255)
);

CREATE SEQUENCE IF NOT EXISTS training_id_seq
	AS BIGINT
	MINVALUE 1
	MAXVALUE 9223372036854775807
	INCREMENT 1
	START 1;

CREATE TABLE IF NOT EXISTS training (
	id BIGINT NOT NULL DEFAULT nextval('training_id_seq') PRIMARY KEY,
	name varchar(255) NOT NULL,
	description varchar(255),
    training_category_id integer,
    CONSTRAINT training_category_id_fk FOREIGN KEY (training_category_id) REFERENCES training_category (id)
        ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE SEQUENCE IF NOT EXISTS training_set_id_seq
	AS BIGINT
	MINVALUE 1
	MAXVALUE 9223372036854775807
	INCREMENT 1
	START 1;

CREATE TABLE IF NOT EXISTS training_set (
	id BIGINT NOT NULL DEFAULT nextval('training_set_id_seq') PRIMARY KEY,
	name varchar(255) NOT NULL,
	description varchar(255)
);

CREATE SEQUENCE IF NOT EXISTS training_to_training_set_id_seq
	AS BIGINT
	MINVALUE 1
	MAXVALUE 9223372036854775807
	INCREMENT 1
	START 1;


CREATE TABLE IF NOT EXISTS training_to_training_set (
	id BIGINT NOT NULL DEFAULT nextval('training_to_training_set_id_seq') PRIMARY KEY,
	name varchar(255) NOT NULL,
	description varchar(255),
	amount varchar(255),
    training_id integer not null,
    training_set_id integer not null,
    CONSTRAINT training_id_fk FOREIGN KEY (training_id) REFERENCES training (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT training_set_id_fk FOREIGN KEY (training_set_id) REFERENCES training_set (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

ALTER TABLE training_category ADD IF NOT EXISTS user_id integer not null;
ALTER TABLE training ADD COLUMN IF NOT EXISTS user_id integer not null;
ALTER TABLE training_set ADD COLUMN IF NOT EXISTS user_id integer not null;

ALTER TABLE training_category ADD COLUMN IF NOT EXISTS deleted boolean default false;
ALTER TABLE training ADD COLUMN IF NOT EXISTS deleted boolean default false;
ALTER TABLE training_set ADD COLUMN IF NOT EXISTS deleted boolean default false;
ALTER TABLE training_to_training_set ADD COLUMN IF NOT EXISTS deleted boolean default false;

ALTER TABLE training_category ADD COLUMN IF NOT EXISTS deleted_AT timestamp with time zone default null;
ALTER TABLE training ADD COLUMN IF NOT EXISTS deleted_AT timestamp with time zone default null;
ALTER TABLE training_set ADD COLUMN IF NOT EXISTS deleted_AT timestamp with time zone default null;
ALTER TABLE training_to_training_set ADD COLUMN if NOT EXISTS deleted_AT timestamp with time zone default null;

SELECT execute_operation_on_column('
   ALTER TABLE training_category ADD CONSTRAINT training_category_to_user_id_fk FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE;
');

SELECT execute_operation_on_column('
   ALTER TABLE training ADD CONSTRAINT training_to_user_id_fk FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE;
');
SELECT execute_operation_on_column('
   ALTER TABLE training_set ADD CONSTRAINT training_set_to_user_id_fk FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE;
');