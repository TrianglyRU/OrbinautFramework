/// @function variable_check(id,name)
function variable_check(id,name)
{
	/* This function is slow and should not be overused! */
	
	// Return value of a variable from the target object
	if instance_exists(id)
	{
		return variable_instance_get(id, name);
	}
	
	// If object doesn't exist, return false
	return false;
}