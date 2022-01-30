function ObjRingMain()
{
	// Play animation (sync for all rings)
	animation_play_sync(sprite_index, 8);
	
	// Check for hitbox collision
	if !Player.Hurt and Player.InvincibilityFrames < 90 and object_check_touch(TypeHitbox)
	{	
		// Add 1 to ring counter
		Player.Rings++;
		
		// Play sound
		audio_sfx_play(Player.Rings mod 2 == 0 ? sfxRingLeft : sfxRingRight, false);
	
		// Create sparkle object in place of the ring
		instance_create(x, y, RingSparkle);	
		instance_destroy();	
	}
	
	switch State
	{
		// Check for being magnetised
		case 0:
		{
			if !Player.DebugMode
			{
				if Player.BarrierType == BarrierThunder and distance_to_object(Player) <= 64
				{
					// Increment state
					State += 1;
					depth  = 0;
				}
			}
		}
		break;
		
		// Attract to the player
		case 1:
		{
			// If player has lost the barrier, replace the ring
			if Player.BarrierType != BarrierThunder
			{
				var  ThisSpeed = [Xsp, Ysp];
				var  NewObject = instance_create(x, y, ShatteredRing);
				with NewObject
				{
					if !Player.Hurt
					{
						PickupTimeout = 0;
					}
					Xsp = ThisSpeed[0];
					Ysp = ThisSpeed[1];
				}
				instance_destroy();
			}
			else
			{
				// Ring acceleration data
				var RingAcceleration = [0.75, 0.1875];
			
				// Get relative position and movement
				var RelativeX = sign(floor(Player.PosX) - x);
				var RelativeY = sign(floor(Player.PosY) - y);
				var MoveX     = (sign(Xsp) == RelativeX);
				var MoveY     = (sign(Ysp) == RelativeY);
	
				// Increase speed and move the ring
				Xsp  += (RingAcceleration[MoveX] * RelativeX);
				Ysp  += (RingAcceleration[MoveY] * RelativeY);
				PosX += Xsp;
				PosY += Ysp;
			
				// Update position
				x = floor(PosX);
				y = floor(PosY);
			}
		}
		break;
	}
}