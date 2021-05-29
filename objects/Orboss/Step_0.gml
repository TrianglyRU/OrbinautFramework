/// @description Insert description here
// You can write your code in this editor
	
	if Timer 
	{	
		Timer--;
		if (Timer = 50) Orb.State = 3;
	}
	else
	{
		AngleX += 0.1;
		AngleY += 0.1;
		Spin = (Spin + 1) mod 360;
	}
	
	if object_player_overlap(CollisionHitbox)
	{
		// Check if player can destroy Badnik
		if Player.Jumping or Player.Rolling or Player.SpindashRev >= 0
		or Player.InvincibilityBonus or Player.GlidingState
		{	
			if !Timer
			{
				audio_sfx_play(sfxDestroy, false, false);
				
				HP--;
				Timer = 180;
				AngleX = 0;
				AngleY = 0;
				Spin = 0;
				
				Orb.State = 2;
			
				// Make player bounce if they are airborne
				if !Player.Grounded
				{
					if floor(Player.PosY) < floor(y)
					{
						Player.Ysp = -Player.Ysp;
					}
					else
					{
						Player.Ysp -= 1 * sign(Player.Ysp);
					}
				}
			
				if !HP
				{
					// Spawn explosion and play sound
					object_spawn(floor(x), floor(y), DustExplosion);
					audio_sfx_play(sfxDestroy, false, false);
					instance_destroy(Orb);
					instance_destroy();
				}
			}
		}
		else
		{
			object_damage(false, false, false);
		}
	}