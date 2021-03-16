function object_set_collision(type)
{	
	// Report script error if got wrong argument
	if type != SolidAll and type != SolidTop and type != SolidNone
	{	
		
		show_message("Wrong argument type set for object ID " + string(id) + " in function 'object_set_collision'. Expected SolidAll (0), SolidTop (1) or SolidNone (2)");
		game_end();
	}	
	
	// Create hitbox collision variable if it does not exist
	variable_init("objPlayerCollided");
	
	// Update collision type
	objCollisionType = type;
}