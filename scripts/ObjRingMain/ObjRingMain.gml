function ObjRingMain()
{
	// Play animation (sync for all rings)
	animation_play_sync(sprite_index, 8);
	
	switch State
	{
		// Check for being magnetised
		case 0:
		{
			if Player.BarrierType == BarrierThunder and distance_to_object(Player) <= 64
			{
				// Increment state
				State++;
			}
		}
		break;
		
		// Attract to the player
		case 1:
		{
			// Set ring acceleration
			var RingAcceleration = [0.75, 0.1875];
			
			// Set relative positions
			var RelativeX = sign(floor(Player.PosX) - x);
			var RelativeY = sign(floor(Player.PosY) - y);
	
			// Check relative movement
			var MoveX = (sign(Xsp) == RelativeX);
			var MoveY = (sign(Ysp) == RelativeY);
	
			// Increase speed and move ring
			Xsp  += (RingAcceleration[MoveX] * RelativeX);
			Ysp  += (RingAcceleration[MoveY] * RelativeY);
			PosX += Xsp;
			PosY += Ysp;
			
			// Update position
			x = floor(PosX);
			y = floor(PosY);
		}
		break;
	}
	
	// Check for hitbox collision
	if !Player.Hurt and Player.InvincibilityFrames < 90 and object_check_overlap(Hitbox)
	{	
		// Add 1 to ring counter
		Player.Rings++;
		
		// Play sound
		audio_sfx_play(Player.Rings mod 2 == 0 ? sfxRingLeft : sfxRingRight, false);
	
		// Create sparkle object in place of the ring
		instance_create(x, y, RingSparkle);	
		instance_destroy();	
	}
}