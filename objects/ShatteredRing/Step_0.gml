/// @description Main
// You can call your scripts in this editor
	
	// Update animation
	animation_play(sprite_index, floor((256 * 2) / Timer), 0);
	
	// Move ring
	PosX += Xsp;
	PosY += Ysp;
	Ysp  += 0.09375;
		
	// Check for floor
	if Ysp >= 0
	{
		var FindFloor = tile_find_v(PosX, PosY + 8, true, Player.Layer)[0];
		if  FindFloor < 0
		{
			PosY += FindFloor;
			Ysp  *= -0.75;
		}
	}
	
	// Perform additional collision checks
	if global.PreciseRingBehaviour
	{
		// Check for ceiling
		if Ysp < 0 
		{
			var FindRoof = tile_find_v(PosX, PosY - 8, false, Player.Layer)[0];
			if  FindRoof < 0
			{
				Ysp *= -0.75;
			}
		}
				
		// Check for left wall
		if Xsp < 0
		{
			var FindWall = tile_find_h(PosX - 8, PosY, false, Player.Layer)[0];
			if  FindWall < 0
			{
				Xsp *= -0.75;
			}
		}
				
		// Check for right wall
		else if Xsp > 0
		{
			var FindWall = tile_find_h(PosX + 8, PosY, false, Player.Layer)[0];
			if  FindWall < 0
			{
				Xsp *= -0.75;
			}
		}
	}
	
	// Update position
	x = floor(PosX);
	y = floor(PosY);
	
	if !(--Timer)
	{
		instance_destroy();
	}
	else
	{		
		// Collect ring
		if PickupTimeout
		{
			PickupTimeout--;
		}
		else if object_check_player(ColHitbox)
		{
			Player.Rings++;
			audio_sfx_play(Player.Rings mod 2 == 0 ? sfxRingLeft : sfxRingRight, false);
	
			instance_create(x, y, RingSparkle);	
			instance_destroy();
		}
	}