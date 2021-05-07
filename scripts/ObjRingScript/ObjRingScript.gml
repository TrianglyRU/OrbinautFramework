function ObjRingScript()
{
	// Check if ring is physical (being lost by player)
	if Physical
	{
		// Play animation
		animation_play(sprite_index, floor((256 * 2) / Timer), 1);
		
		// Decrease 'can't collect' timer
		if (PickupTimeout) PickupTimeout--;
		
		// Do other timer stuff
		CollisionCheck++;		
		Timer--;
		
		// Check if it is time for ring to disappear
		if !Timer
		{
			// Make ring unable to collect
			PickupTimeout = true;
			
			// Slowly make it invisible and destroy
			image_alpha -= 0.1;
			if image_alpha == 0
			{
				instance_destroy(self);
				exit;
			}
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
		if CollisionCheck mod 4 == 0 and Ysp > 0 or Game.RingsPreciseCollision 
		{
			// Check if ring found the tile & collide
			var findFloor = object_collide_tiles_v(false, SideBottom, 0, Player.Layer);
			if  findFloor
			{
				// Invert its speed
				Ysp = min(Ysp * -0.75, -2);
			}
			
			// Do additional collisions if all-side collision is enabled
			if Game.RingsAllSideCollision
			{
				// Collide ceiling
				if Ysp < 0 
				{
					var findCeiling = object_collide_tiles_v(false, SideTop, 0, Player.Layer);
					if  findCeiling
					{
						Ysp *= -0.75;
					}
				}
				
				// Collide left wall
				if Xsp < 0
				{
					var findLWall = object_collide_tiles_h(SideLeft, false, 0, Player.Layer);
					if  findLWall
					{
						Xsp *= -0.75;
					}
				}
				
				// Collide right wall
				if Xsp > 0
				{
					var findRWall = object_collide_tiles_h(SideRight, false, 0, Player.Layer);
					if  findRWall
					{
						Xsp *= -0.75;
					}
				}
			}
		}
		
		// Check if ring is outside the camera X view
		if Game.RingsBoundDespawn
		{
			if x < Screen.CameraX - 8 or x > Screen.CameraX + Screen.Width + 8
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
		//animation_play(sprite_index, 4, 1);
		image_index = Stage.AnimationTime div 4 mod 8;
	}
	
	// Exit the code if ring can't be collected
	if (PickupTimeout) exit;
	
	// Check for hitbox collision
	if object_player_overlap(CollisionHitbox)
	or object_player_overlap_ai(CollisionHitbox)
	{	
		// Add 1 to ring counter
		Player.Rings++;
	
		// Create shine object
		object_spawn(x, y, RingSparkle);	
	
		// Play sound, switch left and right channels every ring
		audio_sfx_play(Player.Rings mod 2 == 0 ? sfxRingLeft : sfxRingRight, false, false);
	
		// Delete ring
		instance_destroy(self);		
	}
}