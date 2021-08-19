function ObjShatteredRingScript()
{
	// Play animation
	animation_play(sprite_index, floor((256 * 2) / Timer), 1);
		
	// Decrease 'can't collect' timer
	if PickupTimeout
	{
		PickupTimeout--;
	}
		
	// Do other timer stuff
	CollisionCheck++;		
		
	// Check if it is time for ring to disappear
	if !(--Timer)
	{
		instance_destroy();
		exit;
	}
	
	// Apply gravity
	Ysp += Grv;
	
	// Move ring
	PosX += Xsp;
	PosY += Ysp;

	// Update object position
	object_update_position(PosX, PosY);
		
	// Do tile collision every four frames when falling down
	if Ysp > 0 and (CollisionCheck mod 4 == 0 or Game.SMRingBehaviour)
	{
		// Check if ring found the tile & collide
		var findFloor = object_collide_tiles_v(false, SideBottom, 0, Player.Layer);
		if  findFloor
		{
			// Invert its speed
			Ysp = min(Ysp * -0.75, -2);
		}
			
		// Do additional collisions if all-side collision is enabled
		if Game.SMRingBehaviour
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
		
	// Exit the code if ring can't be collected
	if PickupTimeout
	{
		exit;
	}
	
	// Check for hitbox collision
	if object_player_overlap(CollisionHitbox)
	{	
		// Add 1 to ring counter
		Player.Rings++;
		
		// Create shine object
		instance_create(x, y, RingSparkle);	
	
		// Play sound, switch left and right channels every ring
		audio_sfx_play(Player.Rings mod 2 == 0 ? sfxRingLeft : sfxRingRight, false);
	
		// Delete ring
		instance_destroy();		
	}
}