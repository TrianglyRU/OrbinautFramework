function ObjRingMain()
{
	// Play animation in sync with all rings
	animation_play_sync(sprite_index, 8);
	
	switch State
	{
		case 0:
		{
			// Check for being magnetised
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
		case 1:
		{
			// If player has lost their barrier, replace the ring object
			if Player.BarrierType != BarrierThunder
			{
				var  ThisSpeed = [Xsp, Ysp];
				var  NewObject = instance_create(x, y, ShatteredRing);
				with NewObject
				{
					Xsp = ThisSpeed[0];
					Ysp = ThisSpeed[1];
				}
				instance_destroy();
			}
			else
			{
				var RingAcc = [0.75, 0.1875];
				var RelX	= sign(floor(Player.PosX) - x);
				var RelY	= sign(floor(Player.PosY) - y);
				var MoveX   = sign(Xsp) == RelX;
				var MoveY   = sign(Ysp) == RelY;
	
				Xsp  += (RingAcc[MoveX] * RelX);
				Ysp  += (RingAcc[MoveY] * RelY);
				PosX += Xsp;
				PosY += Ysp;
			
				// Update position
				x = floor(PosX);
				y = floor(PosY);
			}
		}
		break;
	}
	
	// Collect ring
	if !Player.Hurt and Player.InvincibilityFrames < 90
	{	
		if object_check_touch(ColHitbox)
		{
			Player.Rings++;
			audio_sfx_play(Player.Rings mod 2 == 0 ? sfxRingLeft : sfxRingRight, false);
	
			instance_create(x, y, RingSparkle);	
			instance_destroy();	
		}
	}
}