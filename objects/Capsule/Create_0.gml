/// @description Setup
// You can write your code in this editor
	
	// Init variables
	variable_init("Init");
	variable_init("State");
	variable_init("Timer");
	variable_init("ExplDelay");
	
	// Set object collision type
	object_set_collision(SolidAll);
	
	// Set object hitbox
	object_set_hitbox(32, 26);
	
	// Set object visibility
	object_set_visibility(true);
		
	// Render behind the player
	object_set_depth(Player, false);