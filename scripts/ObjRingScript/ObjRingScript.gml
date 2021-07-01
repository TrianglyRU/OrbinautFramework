function ObjRingScript()
{
	// Play animation
	image_index = Stage.AnimationTime div 4 mod 8;
		
	// Check for being magnetized
	if !Magnetized
	{
		if Player.BarrierType == BarrierThunder and distance_to_object(Player) <= 64
		{
			Magnetized = true;
		}
	}
	else
	{
		var ringacc;
		ringacc[0] = 0.75;
		ringacc[1] = 0.1875;
			
		//relative positions
		var sx = sign(floor(Player.PosX) - floor(PosX));
		var sy = sign(floor(Player.PosY) - floor(PosY));
	
		//check relative movement
		var tx = (sign(Xsp) == sx);
		var ty = (sign(Ysp) == sy);
	
		//add to speed
		Xsp += (ringacc[tx] * sx);
		Ysp += (ringacc[ty] * sy);
	
		//move
		PosX += Xsp;
		PosY += Ysp;
			
		// Update real position
		x = floor(PosX);
		y = floor(PosY);
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