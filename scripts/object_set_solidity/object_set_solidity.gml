function object_set_solidity(type)
{	
	// Accept only SOLID_FULL or SOLID_PLATFORM
	if type != SolidAll and type != SolidTop
	{	
		show_message("Wrong solidity attribute set for object ID " + string(id) + " in function object_set_solidity. Expected SolidAll or SolidTop");
		game_end();
	}	
	
	// If solidity type is correct, set a variable for the object
	variable_instance_set(id, "Solidity", type);
}