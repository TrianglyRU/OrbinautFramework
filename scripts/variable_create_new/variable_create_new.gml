/// @function variable_create_new(name, val)
function variable_create_new(name, val)
{
	if !variable_instance_exists(id, name)
	{
		variable_instance_set(id, name, val);
	}
}