function object_set_solidity(type)
{	
	// Report script error if instance is not set as an object
	if !variable_instance_exists(id, "IsStageObject")
	{
		show_message("Instance ID " + string(id) + " (" + string(object_get_name(self)) + ") is not initialized as object. Please, call function 'object_setup' in the Create or Room Start event");
		game_end();
	}
	
	// Report script error if got wrong argument
	if type != SolidAll and type != SolidTop and type != SolidNone
	{	
		
		show_message("Wrong argument type set for object ID " + string(id) + " in function 'object_set_solidity'. Expected SolidAll (0), SolidTop (1) or SolidNone (2)");
		game_end();
	}	
	
	// Apply solidity
	Solidity = type;
}