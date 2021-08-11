/// @function variable_create_new(name, val)
function variable_create_new(name, val)
{
	if !variable_exists(name)
	{
		variable_instance_set(id, name, val);
	}
}