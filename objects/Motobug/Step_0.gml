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
			Xsp  =  1;
			Dir *= -1;
		}
	}
	
	// Check if Motobug is facing left
	if Dir == DirLeft
	{
		// Move to the left
		x -= Xsp;
	}
	
	// Check if Motobug is facing right
	else if Dir == DirRight
	{
		// Move to the right
		x += Xsp;
	}
	
	// Check if Motobug's speed is 0
	if Xsp != 0
	{
		// Collide tiles & check for if Motobug is 2 pixels away from the surface
		var collideFloor = object_collide_tiles_v(false, SideBottom, 2, LayerA);
		if !collideFloor
		{
			// Stop Motobug
			StopTimer = 60;
			Xsp       = 0;
		}
	}
	
	// Set xscale to Motobug direction
	image_xscale = Dir;
	
	// Check for hitbox overlap
	if object_player_overlap(CollisionHitbox)
	{
		// Damage player or be destroyed
		object_damage(true, false, false);
	}