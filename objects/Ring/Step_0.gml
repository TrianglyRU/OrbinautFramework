/// @description Collect
// You can call your scripts in this editor

	if hitbox_collision(Player, self)
	{	
		// Add 1 to ring counter
		Player.Rings++;
		
		// Create shine object
		instance_create_depth(x, y, depth - 1, ShineFX);	
		
		// Play sound
		play_sound(sfxRing, false);
		
		// Destroy ring
		instance_destroy(self);		
	}