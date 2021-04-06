/// @function variable_init(variable)
function variable_init(variable)
{
	if !variable_instance_exists(id, variable)
	{
		variable_instance_set(id, variable, 0);
	}
}