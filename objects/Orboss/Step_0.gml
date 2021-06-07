/// @description Insert description here
// You can write your code in this editor
	switch State
	{
		case 0:
			StateTimer--;
			PosY++;
			if !StateTimer
			{
				State = 1;
				image_index = 0;
			}
			if (StateTimer = 50) Orb.State = 3;
		break;
		case 1:
			if HurtTimer 
			{	
				HurtTimer--;
				if (HurtTimer = 50) Orb.State = 3;
			}
			else
			{	
				AngleX += 3;
				AngleY += 6;
				Spin = (Spin + 1) mod 360;
			}
		break;
	
	}
	
	x = floor(PosX);
	y = floor(PosY);
	
	if keyboard_check_pressed(ord("V"))
	{
		HP = 0;
	}
	if !HP
	{
		// Spawn explosion and play sound
		instance_create(x, y, DustExplosion);
		audio_sfx_play(sfxDestroy, false, false);
		instance_destroy(Orb);
		instance_destroy();
					
		// Tell the controller boss was defeated
		BossController.BossDefeated = true;
	}
	
	if object_player_overlap(CollisionHitbox)
	{
		// Check if player can destroy Badnik
		if Player.Jumping or Player.Rolling or Player.SpindashRev >= 0
		or Player.InvincibilityBonus or Player.GlidingState
		{	
			if !HurtTimer
			{
				audio_sfx_play(sfxDestroy, false, false);
				
				HP--;
				HurtTimer  = 180;
				AngleX = 0;
				AngleY = 0;
				Spin   = 0;
				
				Orb.State = 2;
			
				// Make player bounce if they are airborne
				if !Player.Grounded
				{
					if floor(Player.PosY) < y
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
					instance_create(x, y, DustExplosion);
					audio_sfx_play(sfxDestroy, false, false);
					instance_destroy(Orb);
					instance_destroy();
					
					// Tell the controller boss was defeated
					BossController.BossDefeated = true;
				}
			}
		}
		else
		{
			object_damage(false, false, false, false);
		}
	}