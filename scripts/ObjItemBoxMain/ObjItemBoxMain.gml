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
				if Player.Ysp < 0 and !Player.DoubleSpinAttack
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
				var Check = Player.Ysp >= 0 or Player.DoubleSpinAttack;
			}
			if Check and (Player.Spinning or Player.GlideState > GlideFall) and Player.OnObject != id
			{
				// Destroy on overlap
				if object_check_overlap(TypeHitbox2)
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
				var FindFloor = tile_find_v(PosX, PosY + 15, true, false, Player.Layer)[0];
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
				// Give 10 rings
				case "10 Rings":
				{
					Player.Rings += 10;	
					
					audio_sfx_play(Player.Rings mod 2 == 0 ? sfxRingLeft : sfxRingRight, false);
				}
				break;
				
				// Temporary increase speed
				case "High Speed":
				{
					if !Player.SuperState
					{
						audio_bgm_play(TypePrimary, HighSpeed);
					}
					Player.HighspeedBonus = 1200;
				}
				break;
				
				// Grant temporary invincibility
				case "Invincibility":
				{
					if Player.SuperState
					{
						break;
					}
					Player.InvincibleBonus = 1200;
					
					audio_bgm_play(TypePrimary, Invincibility);
				}
				break;
				
				// Grant regular Barrier
				case "Barrier":
				{
					Player.BarrierType = BarrierNormal;
					
					if !instance_exists(Barrier)
					{
						instance_create(Player.PosX, Player.PosY, Barrier);
					}
					else with Barrier
					{
						object_set_depth(Player, 1); 
						animation_play(spr_obj_barrier_normal, 2, 0);
					}
					audio_sfx_play(sfxBarrier, false);
				}
				break;
				
				// Grant Flame Barrier
				case "Flame Barrier":
				{
					Player.BarrierType = BarrierFlame;
					
					if !instance_exists(Barrier)
					{
						instance_create(Player.PosX, Player.PosY, Barrier);
					}
					else with Barrier
					{
						animation_play(spr_obj_barrier_flame, 2, 0);
					}
					audio_sfx_play(sfxFlameBarrier, false);
				}
				break;
				
				// Grant Thunder Barrier
				case "Thunder Barrier":
				{
					Player.BarrierType = BarrierThunder;
					
					if !instance_exists(Barrier)
					{
						instance_create(Player.PosX, Player.PosY, Barrier);
					}
					else with Barrier
					{
						animation_play(spr_obj_barrier_thunder, 2, 0);
					}
					audio_sfx_play(sfxThunderBarrier, false);
				}
				break;
				
				// Grant Water Barrier
				case "Water Barrier":
				{
					Player.BarrierType = BarrierWater;
					
					if !instance_exists(Barrier)
					{
						instance_create(Player.PosX, Player.PosY, Barrier);
					}
					else with Barrier
					{
						object_set_depth(Player, 1); 
						animation_play(spr_obj_barrier_water, 2, 0);
					}
					audio_sfx_play(sfxWaterBarrier, false);
						
					if Player.AirTimer <= 720
					{	
						// Play previous track if player was running out of air
						if !Player.SuperState
						{
							if Player.InvincibleBonus
							{
								audio_bgm_play(TypePrimary, Invincibility);
							}
							else if Player.HighspeedBonus
							{
								audio_bgm_play(TypePrimary, HighSpeed);
							}
							else
							{
								audio_bgm_play(TypePrimary, Stage.StageMusic);
							}
						}
						else
						{
							audio_bgm_play(TypePrimary, SuperTheme);
						}
					}
					Player.AirTimer = 1800;
				}
				break;
				
				// Grant 1-up
				case "Extra Life":
				{
					Player.Lives++;
					audio_bgm_play(TypeSecondary, ExtraLife);
				}
				break;
				
				// Damage player
				case "Eggman":
				{
					player_damage(false, false, false);
				}
				break;
			}
		}
		break;
		
		// Display item card for 30 frames
		case 2:
		{
			if !(--Timer)
			{
				State++;
			}
			object_set_unload(TypePause);
		}
		break;
	}
}