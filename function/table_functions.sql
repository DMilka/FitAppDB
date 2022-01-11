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