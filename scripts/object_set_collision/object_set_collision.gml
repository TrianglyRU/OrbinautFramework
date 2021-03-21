function object_set_collision(type)
{	
	// Report script error if got wrong argument
	if type != SolidAll and type != SolidTop and type != SolidNone
	{	
		
		show_message("Wrong argument type set for object ID " + string(id) + " in function 'object_set_collision'. Expected SolidAll (0), SolidTop (1) or SolidNone (2)");
		game_end();
	}	
	
	// Set collision type
	objCollisionType = type;
	
	// Initialize variables for collision with player's inner hitbox
	variable_init("objGotPlayerInHitbox");
	
	// Initialize variables for collision with player's outer hitbox
	variable_init("objGotPlayerOutHitboxLeft");	
	variable_init("objGotPlayerOutHitboxRight");	
	variable_init("objGotPlayerOutHitboxTop");	
	variable_init("objGotPlayerOutHitboxBottom");	
}