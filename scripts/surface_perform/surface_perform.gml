/// @function surface_perform(id)
function surface_perform(id)
{	
	if surface_exists(id)
	{
		surface_set_target(id);
		return true;
	}
	return false;
}