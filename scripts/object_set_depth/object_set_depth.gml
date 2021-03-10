/// @function object_set_depth(abovePlayer)
function object_set_depth(abovePlayer)
{
	// Report script error if instance is not set as an object
	if !variable_instance_exists(id, "IsStageObject")
	{
		show_message("Instance ID " + string(id) + " (" + string(object_get_name(self)) + ") is not initialized as object. Please, call function 'object_setup' in the Create or Room Start event");
		game_end();
	}
	
	// Apply depth
	depth = Player.DrawOrder - (abovePlayer ? 1 : -1);
}