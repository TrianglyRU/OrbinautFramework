/// @description Insert description here
// You can write your code in this editor

	// Check if timer is higher than 0
	if StopTimer 
	{
		// Count it down
		StopTimer--;
		
		// If it counted to 0, flip badnik and restore speed
		if !StopTimer
		{
			sprite_index = spr_badnik_crabmeat_move;
			Xsp  =  0.5;
			Dir *= -1;
			
			// Set xscale to Crabmeat direction
			image_xscale = Dir;
		}
	}
	
	x += Xsp * Dir;
	
	if Xsp != 0
	{
		// Collide tiles & check for if Crabmeat is 2 pixels away from the surface
		var collideFloor = object_collide_tiles_v(false, SideBottom, 2, LayerA);
		if !collideFloor
		{
			// Stop Motobug
			StopTimer = 120;
			Xsp       = 0;
			sprite_index = spr_badnik_crabmeat_idle;
		}
	}
	
	// Check for hitbox overlap
	if object_player_overlap(CollisionHitbox)
	{
		// Damage player or be destroyed
		object_act_badnik(true, false);
	}