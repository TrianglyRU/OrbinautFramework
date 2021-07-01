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
	Timer--;
		
	// Check if it is time for ring to disappear
	if !Timer
	{
		instance_destroy();
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
	if !Game.RingsNoBoundDespawn
	{
		if x < Screen.CameraX - 8 or x > Screen.CameraX + Screen.Width + 8
		{
			// Delete it
			instance_destroy();
			exit;
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
		
		// Give extra life
		if Player.Rings >= 100 and Player.LivesRewards == 0
		or Player.Rings >= 200 and Player.LivesRewards == 1
		{
			Player.Lives++;
			Player.LivesRewards++;
			audio_bgm_play(Jingle1UP, noone, 0, TypeJingle);
		}
	
		// Create shine object
		instance_create(x, y, RingSparkle);	
	
		// Play sound, switch left and right channels every ring
		audio_sfx_play(Player.Rings mod 2 == 0 ? sfxRingLeft : sfxRingRight, false);
	
		// Delete ring
		instance_destroy();		
	}
}