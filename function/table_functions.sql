create or replace function execute_operation_on_column(character varying) returns boolean as '
declare
	query alias for $1;
begin
	execute query;
	return true;
	exception
		when DUPLICATE_COLUMN then
			return false;
end;
' language plpgsql;

create or replace function execute_constraint_on_table(character varying) returns boolean as '
declare
	query alias for $1;
begin
	execute query;
	return true;
	exception
		when DUPLICATE_OBJECT then
			return false;
end;
' language plpgsql;

create or replace function execute_operation_on_column_ignore_if_not_exist(character varying) returns boolean as '
declare
	query alias for $1;
begin
	execute query;
	return true;
	exception
		when UNDEFINED_COLUMN then
			return false;
end;
' language plpgsql;