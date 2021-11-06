function ObjItemBoxMain()
{
	switch State
	{
		// Not destroyed
		case 0:
		{
			// Handle item card flick
			if !(--Timer)
			{
				Timer = 5;
			}

			// Check if player is able to destroy it
			if Game.SKItemBoxBehaviour
			{
				if Player.Ysp < 0
				{
					var Check = floor(Player.PosY + 16) >= y;
				}
				else
				{
					var Check = true;
				}
			}
			else
			{
				var Check = Player.Ysp >= 0;
			}
			if Check and (Player.Spinning or Player.GlideState > GlideFall) and Player.OnObject != id
			{
				// Destroy on overlap
				if object_check_overlap(TypeHitbox)
				{
					// Inverse player's speed
					if !Player.Grounded
					{
						Player.Ysp = -Player.Ysp;
					}
					
					// Create explosion
					instance_create(PosX, PosY, DustExplosion);
					audio_sfx_play(sfxDestroy, false);
				
					// Temporary do not unload the object
					object_set_unload(false);	

					// Increment state
					Timer = 0;
					State++;
				}
			}
				
			// If not, just collide
			else
			{
				// Do collision
				object_act_solid(true, true, false, false);
					
				// Make itembox fall down
				if !IsFalling and floor(Player.PosY) >= floor(y + 16)
				{
					if object_check_overlap(TypeHitbox)
					{
						IsFalling  = true;
						Ysp        = -1.5;
						Player.Ysp = -Player.Ysp;
					}
				}
			}
		
			// Check if itembox is airborne
			if IsFalling
			{
				// Move
				Ysp  += 0.21875;
				PosY += Ysp;
			
				// Collide with floor
				var FindFloor = tile_check_collision_v(PosX, PosY + 15, true, false, Player.Layer)[0];
				if  FindFloor < 0
				{
					PosY     += FindFloor;
					IsFalling = false;
				}
			
				// Update position
				x = floor(PosX);
				y = floor(PosY);
			}
			
			// Update card position
			CardX = x;
			CardY = y - 3;
		}
		break;
		
		// Destroyed
		case 1:
		{	
			// Update animation
			if (++Timer) == 12
			{
				animation_set(spr_obj_itembox_destroyed, 0);
			}
			
			// Move item card
			CardSpeed = max(CardSpeed - 0.09375, 0);
			CardY	 -= CardSpeed;
			
			// If card is moving, exit
			if CardSpeed 
			{
				break;
			}
			
			// Increment state
			Timer = 30;
			State++;
			
			// Give bonus
			switch BoxType
			{
				case "10 Rings":
				{
					// Give 10 rings
					Player.Rings += 10;
						
					// Play ring sound
					audio_sfx_play(Player.Rings mod 2 == 0 ? sfxRingLeft : sfxRingRight, false);
				}
				break;
				case "High Speed":
				{
					// Give highspeed bonus for 20 seconds
					Player.HighspeedBonus = 1200;
						
					// Play music
					if !Player.SuperState
					{
						audio_bgm_play(PriorityLow, HighSpeed, 0, 0);
					}
				}
				break;
				case "Invincibility":
				{
					// If in super form, exit
					if Player.SuperState
					{
						break;
					}
					
					// Give invincibility bonus for 20 seconds if not in super form
					Player.InvincibleBonus = 1200;
						
					// Play music
					audio_bgm_play(PriorityLow, Invincibility, other, other);
				}
				break;
				case "Barrier":
				{
					// Give normal barrier
					Player.BarrierType = BarrierNormal;
						
					// Spawn barrier object
					if !instance_exists(Barrier)
					{
						instance_create(Player.PosX, Player.PosY, Barrier);
					}
					
					// Play sound
					audio_sfx_play(sfxBarrier, false);
				}
				break;
				case "Flame Barrier":
				{
					// Give flame barrier
					Player.BarrierType = BarrierFlame;
						
					// Spawn barrier object
					if !instance_exists(Barrier)
					{
						instance_create(Player.PosX, Player.PosY, Barrier);
					}
					
					// Play sound
					audio_sfx_play(sfxFlameBarrier, false);
				}
				break;
				case "Thunder Barrier":
				{
					// Give thunder barrier
					Player.BarrierType = BarrierThunder;
						
					// Spawn barrier object
					if !instance_exists(Barrier)
					{
						instance_create(Player.PosX, Player.PosY, Barrier);
					}
					
					// Play sound
					audio_sfx_play(sfxThunderBarrier, false);
				}
				break;
				case "Water Barrier":
				{
					// Give water barrier
					Player.BarrierType = BarrierWater;	
						
					// Spawn barrier object
					if !instance_exists(Barrier)
					{
						instance_create(Player.PosX, Player.PosY, Barrier);
					}
					
					// Play sound
					audio_sfx_play(sfxWaterBarrier, false);
						
					// Play previous track if running out of air
					if Player.AirTimer <= 720
					{	
						if !Player.SuperState
						{
							if Player.InvincibleBonus
							{
								audio_bgm_play(PriorityLow, Invincibility, 0, 0);
							}
							else if Player.HighspeedBonus
							{
								audio_bgm_play(PriorityLow, HighSpeed, 0, 0);
							}
							else
							{
								audio_bgm_play(PriorityLow, Stage.StageMusic, 0, 0);
							}
						}
						else
						{
							audio_bgm_play(PriorityLow, SuperTheme, 0, 0);
						}
					}
			
					// Reset air timer
					Player.AirTimer = 1800;
				}
				break;
				case "Extra Life":
				{
					// Give player 1 extra life
					Player.Lives++;
						
					// Play jingle
					audio_bgm_play(PriorityHigh, ExtraLife, 0, 0);
				}
				break;
				case "Eggman":
				{
					// Damage player
					player_damage(false, false, false);
				}
				break;
			}
		}
		break;
		
		// Display card for 30 more frames
		case 2:
		{
			if !(--Timer)
			{
				// Increment state
				State++;
			}
			
			// Set object unload type
			object_set_unload(TypePause);
		}
		break;
	}
}