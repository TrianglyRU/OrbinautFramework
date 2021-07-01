/// @function variable_set_temp(variable)
function variable_set_temp(variable)
{
	if !variable_instance_exists(id, variable)
	{
		variable_instance_set(id, variable, 0);
	}
}