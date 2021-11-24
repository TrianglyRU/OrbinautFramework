function ObjShatteredRingMain()
{
	// Set animation
	animation_play(sprite_index, floor((256 * 2) / Timer), 0, 0);
	
	// Move ring
	PosX += Xsp;
	PosY += Ysp;
	Ysp  += 0.09375;
		
	// Collide with floor
	if Ysp > 0
	{
		var FindFloor = tile_find_v(PosX, PosY + 8, true, false, Player.Layer)[0];
		if  FindFloor < 0 and FindFloor > -15
		{
			PosY += FindFloor;
			Ysp  *= -0.75;
		}
	}
	
	// Perform additional collision checks
	if Game.PreciseRingBehaviour
	{
		// Collide with ceiling
		if Ysp < 0 
		{
			var FindRoof = tile_find_v(PosX, PosY - 8, false, true, Player.Layer)[0];
			if  FindRoof < 0
			{
				Ysp *= -0.75;
			}
		}
				
		// Collide with left wall
		if Xsp < 0
		{
			var FindWall = tile_find_h(PosX - 8, PosY, false, true, Player.Layer)[0];
			if  FindWall < 0
			{
				Xsp *= -0.75;
			}
		}
				
		// Collide with right wall
		else if Xsp > 0
		{
			var FindWall = tile_find_h(PosX + 8, PosY, false, true, Player.Layer)[0];
			if  FindWall < 0
			{
				Xsp *= -0.75;
			}
		}
	}
	
	// Update position
	x = floor(PosX);
	y = floor(PosY);
	
	// Check if it is time for ring to disappear
	if !(--Timer)
	{
		instance_destroy();
	}
	else
	{		
		// Check for hitbox collision
		if PickupTimeout
		{
			PickupTimeout--;
		}
		else if object_check_overlap(TypeHitbox)
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
}