CREATE SEQUENCE IF NOT EXISTS schedule_id_seq
	AS BIGINT
	MINVALUE 1
	MAXVALUE 9223372036854775807
	INCREMENT 1
	START 1;
	
CREATE TABLE IF NOT EXISTS schedule (
	id BIGINT NOT NULL DEFAULT nextval('schedule_id_seq') PRIMARY KEY,
	planned_at DATE NOT NULL,
	user_id INTEGER NOT NULL,
    deleted BOOLEAN NOT NULL DEFAULT FALSE,
    deleted_at TIMESTAMP WITH TIME ZONE DEFAULT NULL,
    CONSTRAINT schedule_user_fk FOREIGN KEY (user_id) REFERENCES users (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE SEQUENCE IF NOT EXISTS meal_set_to_schedule_id_seq
	AS BIGINT
	MINVALUE 1
	MAXVALUE 9223372036854775807
	INCREMENT 1
	START 1;


CREATE TABLE IF NOT EXISTS meal_set_to_schedule (
    id BIGINT NOT NULL DEFAULT nextval('meal_set_to_schedule_id_seq') PRIMARY KEY,
    meal_set_id INTEGER NOT NULL,
    schedule_id INTEGER NOT NULL,
    deleted BOOLEAN NOT NULL DEFAULT FALSE,
    deleted_at TIMESTAMP WITH TIME ZONE DEFAULT NULL,
    CONSTRAINT meal_set_to_meal_set_to_schedule_fk FOREIGN KEY (meal_set_id) REFERENCES meal_set (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT schedule_to_meal_set_to_schedule_fk FOREIGN KEY (schedule_id) REFERENCES schedule (id)
        ON DELETE CASCADE ON UPDATE CASCADE
    );

CREATE SEQUENCE IF NOT EXISTS training_set_to_schedule_id_seq
	AS BIGINT
	MINVALUE 1
	MAXVALUE 9223372036854775807
	INCREMENT 1
	START 1;


CREATE TABLE IF NOT EXISTS training_set_to_schedule (
    id BIGINT NOT NULL DEFAULT nextval('training_set_to_schedule_id_seq') PRIMARY KEY,
    training_set_id INTEGER NOT NULL,
    schedule_id INTEGER NOT NULL,
    deleted BOOLEAN NOT NULL DEFAULT FALSE,
    deleted_at TIMESTAMP WITH TIME ZONE DEFAULT NULL,
    CONSTRAINT training_set_to_training_set_to_schedule_fk FOREIGN KEY (training_set_id) REFERENCES training_set (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT schedule_to_training_set_to_schedule_fk FOREIGN KEY (schedule_id) REFERENCES schedule (id)
        ON DELETE CASCADE ON UPDATE CASCADE
    );