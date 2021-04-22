function ObjRingScript()
{
	// Check if ring is physical (being lost by player)
	if Physical
	{
		// Play animation
		animation_play(sprite_index, floor((256 * 2) / Timer), 1);
		
		// Do timer stuff
		if (PickupTimeout > 0) PickupTimeout--;
		CollisionCheck++;
		Timer--;
		
		// Check for timeout
		if !Timer
		{
			instance_destroy(self);
			exit;
		}
	
		// Apply gravity
		Ysp += Grv;
	
		// Update code position
		PosX += Xsp;
		PosY += Ysp;
		
		// Update real position
		x = floor(PosX);
		y = floor(PosY);
		
		// Do tile collision every four frames when falling down
		if (CollisionCheck mod 4 == 0 and Ysp > 0 or Game.RingsPreciseCollision) 
		{
			// Check if ring found the tile
			if object_collide_tiles_v(false, SideBottom, 0, Player.Layer)
			{
				// Invert its speed
				Ysp = min(Ysp * -0.75, -2);
			}
			
			// TODO: Optimzie
			if Game.RingsAllSideCollision
			{
				if Ysp < 0 and object_collide_tiles_v(false, SideTop, 0, Player.Layer)
				{
					Ysp *= -0.75;
				}
				if Xsp < 0 and object_collide_tiles_h(SideLeft, false, 0, Player.Layer)
				{
					Xsp *= -0.75;
				}
				if Xsp > 0 and object_collide_tiles_h(SideRight, false, 0, Player.Layer)
				{
					Xsp *= -0.75;
				}
			}
		}
		
		// Check if ring is outside the camera X view
		if Game.RingsBoundDespawn
		{
			if x < Screen.RenderX - 8 or x > Screen.RenderX + Screen.Width + 8
			{
				// Delete it
				instance_destroy(self);
				exit;
			}
		}
	}
	
	// If ring is static, just play its animation
	else
	{
		// Play animation
		animation_play(sprite_index, 4, 1);
	}
	
	// Check for hitbox collision
	if !PickupTimeout and object_check_overlap(CollisionHitbox)
	{	
		// Add 1 to ring counter
		Player.Rings++;
	
		// Create shine object (depth will be set on RingSparkle creation)
		instance_create_depth(x, y, depth, RingSparkle);	
	
		// Play sound, switch left and right channels every ring
		audio_sfx_play(Player.Rings mod 2 == 0 ? sfxRingLeft : sfxRingRight, false, false);
	
		// Delete ring
		instance_destroy(self);		
	}
}