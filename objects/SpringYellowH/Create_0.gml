/// @description Setup
// You can call your scripts in this editor

	// Set object collision type
	object_set_collision(SolidAll);
	
	// Set object hitbox
	object_set_hitbox(8, 16);
	
	// Set object visibility
	object_set_visibility(true);
		
	// Render behind the player
	object_set_depth(Player, false);