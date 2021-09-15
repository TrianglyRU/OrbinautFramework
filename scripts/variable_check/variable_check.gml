/// @function variable_check(id,name)
function variable_check(id,name)
{
	// Return value of a variable from the target object
	if instance_exists(id)
	{
		return variable_instance_get(id, name);
	}
	
	// If object doesn't exist, return false
	return false;
}