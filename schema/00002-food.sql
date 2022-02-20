CREATE SEQUENCE IF NOT EXISTS ingredient_id_seq
	AS BIGINT
	MINVALUE 1
	MAXVALUE 9223372036854775807
	INCREMENT 1
	START 1;

CREATE SEQUENCE IF NOT EXISTS amount_type_id_seq
	AS BIGINT
	MINVALUE 1
	MAXVALUE 9223372036854775807
	INCREMENT 1
	START 1;

CREATE SEQUENCE IF NOT EXISTS meal_id_seq
	AS BIGINT
	MINVALUE 1
	MAXVALUE 9223372036854775807
	INCREMENT 1
	START 1;

CREATE SEQUENCE IF NOT EXISTS ingredient_to_meal_id_seq
	AS BIGINT
	MINVALUE 1
	MAXVALUE 9223372036854775807
	INCREMENT 1
	START 1;

CREATE SEQUENCE IF NOT EXISTS meal_set_id_seq
	AS BIGINT
	MINVALUE 1
	MAXVALUE 9223372036854775807
	INCREMENT 1
	START 1;

CREATE SEQUENCE IF NOT EXISTS meal_to_meal_set_id_seq
	AS BIGINT
	MINVALUE 1
	MAXVALUE 9223372036854775807
	INCREMENT 1
	START 1;

CREATE TABLE IF NOT EXISTS amount_type (
	id BIGINT NOT NULL DEFAULT nextval('amount_type_id_seq') PRIMARY KEY,
	name varchar(255) NOT NULL,
	description varchar(255)
);

CREATE TABLE IF NOT EXISTS ingredient (
	id BIGINT NOT NULL DEFAULT nextval('ingredient_id_seq') PRIMARY KEY,
	name varchar(255) NOT NULL,
	description varchar(255),
	amount numeric(10,2) NOT NULL,
	protein numeric(10,2),
	carbohydrate numeric(10,2),
	fat numeric(10,2),
	calorie numeric(10,2),
	user_id integer not null,
    amount_type_id integer not null,
    CONSTRAINT ingredient_user_fk FOREIGN KEY (user_id) REFERENCES users (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT ingredient_amount_type_fk FOREIGN KEY (amount_type_id) REFERENCES amount_type (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS meal (
	id BIGINT NOT NULL DEFAULT nextval('meal_id_seq') PRIMARY KEY,
	name varchar(255) NOT NULL,
	description varchar(255)
);

CREATE TABLE IF NOT EXISTS ingredient_to_meal (
	id BIGINT NOT NULL DEFAULT nextval('ingredient_to_meal_id_seq') PRIMARY KEY,
	ingredient_id INTEGER NOT NULL,
	meal_id INTEGER NOT NULL,
    CONSTRAINT ingredient_to_meal_ingredient_fk FOREIGN KEY (ingredient_id) REFERENCES ingredient (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT ingredient_to_meal_meal_fk FOREIGN KEY (meal_id) REFERENCES meal (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS meal_set (
	id BIGINT NOT NULL DEFAULT nextval('meal_set_id_seq') PRIMARY KEY,
	name varchar(255) NOT NULL,
	description varchar(255)
);

CREATE TABLE IF NOT EXISTS meal_to_meal_set (
	id BIGINT NOT NULL DEFAULT nextval('meal_to_meal_set_id_seq') PRIMARY KEY,
	meal_id INTEGER NOT NULL,
	meal_set_id INTEGER NOT NULL,
    CONSTRAINT meal_to_meal_to_meal_set_fk FOREIGN KEY (meal_id) REFERENCES meal (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT meal_set_to_meal_to_meal_set_fk FOREIGN KEY (meal_set_id) REFERENCES meal_set (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

ALTER TABLE ingredient ALTER COLUMN amount TYPE integer;
ALTER TABLE ingredient ALTER COLUMN protein TYPE integer;
ALTER TABLE ingredient ALTER COLUMN carbohydrate TYPE integer;
ALTER TABLE ingredient ALTER COLUMN fat TYPE integer;
ALTER TABLE ingredient ALTER COLUMN calorie TYPE integer;

SELECT execute_operation_on_column('
    ALTER TABLE ingredient ADD COLUMN divider_value integer default 100;
');

SELECT execute_operation_on_column('
    ALTER TABLE meal ADD COLUMN user_id integer not null;
');
SELECT execute_operation_on_column('
   ALTER TABLE meal_set ADD COLUMN user_id integer not null;
');

SELECT execute_operation_on_column('
   ALTER TABLE ingredient ADD COLUMN deleted boolean default false not null;
');

SELECT execute_operation_on_column('
   ALTER TABLE ingredient ADD COLUMN deleted_at timestamp with time zone default null;
');

SELECT execute_operation_on_column('
   ALTER TABLE amount_type ADD COLUMN deleted boolean default false not null;
');

SELECT execute_operation_on_column('
   ALTER TABLE amount_type ADD COLUMN deleted_at timestamp with time zone default null;
');

SELECT execute_operation_on_column('
   ALTER TABLE meal ADD COLUMN deleted boolean default false not null;
');

SELECT execute_operation_on_column('
   ALTER TABLE meal ADD COLUMN deleted_at timestamp with time zone default null;
');

SELECT execute_operation_on_column('
   ALTER TABLE meal ADD COLUMN deleted boolean default false not null;
');

SELECT execute_operation_on_column('
   ALTER TABLE meal ADD COLUMN deleted_at timestamp with time zone default null;
');

SELECT execute_operation_on_column('
   ALTER TABLE ingredient_to_meal ADD COLUMN deleted boolean default false not null;
');

SELECT execute_operation_on_column('
   ALTER TABLE ingredient_to_meal ADD COLUMN deleted_at timestamp with time zone default null;
');

SELECT execute_operation_on_column('
   ALTER TABLE meal_to_meal_set ADD COLUMN deleted boolean default false not null;
');

SELECT execute_operation_on_column('
   ALTER TABLE meal_to_meal_set ADD COLUMN deleted_at timestamp with time zone default null;
');

SELECT execute_operation_on_column('
   ALTER TABLE users ADD COLUMN deleted boolean default false not null;
');

SELECT execute_operation_on_column('
   ALTER TABLE users ADD COLUMN deleted_at timestamp with time zone default null;
');

SELECT execute_operation_on_column('
   ALTER TABLE meal_set ADD COLUMN deleted boolean default false not null;
');

SELECT execute_operation_on_column('
   ALTER TABLE meal_set ADD COLUMN deleted_at timestamp with time zone default null;
');