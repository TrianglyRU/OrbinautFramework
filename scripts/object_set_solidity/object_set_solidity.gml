/// @function object_set_solidity(type)
function object_set_solidity(type)
{	
	// Report script error
	if type != SolidAll and type != SolidTop
	{	
		show_message("Wrong solidity attribute set for object ID " + string(id) + " in function object_set_solidity. Expected SolidAll (0) or SolidTop (1)");
		game_end();
	}
	
	// If solidity type is correct, set a variable for the object
	Solidity = type;
}