function ObjShatteredRingMain()
{
	// Play animation
	animation_play(sprite_index, floor((256 * 2) / Timer), 1);
		
	// Decrease pickup timer
	if PickupTimeout
	{
		PickupTimeout--;
	}
	
	// Check if it is time for ring to disappear
	if !(--Timer)
	{
		instance_destroy();
	}
	
	// Move ring
	PosX += Xsp;
	PosY += Ysp;
	Ysp  += Grv;

	// Update position
	object_update_position(PosX, PosY);
		
	// Do collision
	if Ysp > 0 and (++CollisionCheck mod 4 == 0 or Game.SMRingBehaviour)
	{
		// Collide with floor
		var FindFloor = object_collide_tiles_v(SideCentre, SideBottom, 0, Player.Layer);
		if  FindFloor
		{
			Ysp = min(Ysp * -0.75, -2);
		}
			
		// Do additional collisions if all-side collision is enabled
		if Game.SMRingBehaviour
		{
			// Collide with ceiling
			if Ysp < 0 
			{
				var FindCeiling = object_collide_tiles_v(SideCentre, SideTop, 0, Player.Layer);
				if  FindCeiling
				{
					Ysp *= -0.75;
				}
			}
				
			// Collide with left wall
			if Xsp < 0
			{
				var FindWall = object_collide_tiles_h(SideLeft, SideCentre, 0, Player.Layer);
				if  FindWall
				{
					Xsp *= -0.75;
				}
			}
				
			// Collide with right wall
			if Xsp > 0
			{
				var FindWall = object_collide_tiles_h(SideRight, SideCentre, 0, Player.Layer);
				if  FindWall
				{
					Xsp *= -0.75;
				}
			}
		}
	}
		
	// Check for hitbox collision
	if !PickupTimeout and object_player_overlap(Hitbox)
	{
		// Add 1 to ring counter
		Player.Rings++;
		
		// Play sound
		audio_sfx_play(Player.Rings mod 2 == 0 ? sfxRingLeft : sfxRingRight, false);
	
		// Create sparkle object in place of ring
		instance_create(x, y, RingSparkle);	
		instance_destroy();
	}
}