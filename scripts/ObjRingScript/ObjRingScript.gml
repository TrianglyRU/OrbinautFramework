function ObjRingScript()
{
	// Play animation
	animation_play_sync(sprite_index, 8);
		
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
		var ringacc = [0.75, 0.1875];
			
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
		object_update_position(PosX, PosY);
	}
	
	// Check for hitbox collision
	if !Player.Hurt and Player.InvincibilityFrames < 90 and object_player_overlap(CollisionHitbox)
	{	
		// Add 1 to ring counter
		Player.Rings++;
		
		// Grant extra life
		if Player.Rings >= 100 and Player.LivesRewards == 0
		or Player.Rings >= 200 and Player.LivesRewards == 1
		{
			Player.Lives++;
			Player.LivesRewards++;
			audio_bgm_play(PriorityHigh, ExtraLifeJingle, noone);
		}
	
		// Create shine object
		instance_create(x, y, RingSparkle);	
	
		// Play sound, switch left and right channels every ring
		audio_sfx_play(Player.Rings mod 2 == 0 ? sfxRingLeft : sfxRingRight, false);
	
		// Delete ring
		instance_destroy();		
	}
}