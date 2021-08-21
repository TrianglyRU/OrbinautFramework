/// @function variable_check(id,name)
function variable_check(id,name)
{
	if instance_exists(id)
	{
		return variable_instance_get(id, name);
	}
	return false;
}