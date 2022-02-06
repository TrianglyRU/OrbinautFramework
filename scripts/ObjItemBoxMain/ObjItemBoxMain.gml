function ObjItemBoxMain()
{
	switch State
	{
		case 0:
		{
			// Flick item card
			if !(--Timer)
			{
				Timer = 5;
			}

			// Check if player is able to destroy the object
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
			
			// If so, destroy
			if Check and (Player.Spinning or Player.GlideState > GlideFall) and Player.OnObject != id
			{
				if object_check_touch(TypeHitbox2)
				{
					if !Player.Grounded
					{
						Player.Ysp = -Player.Ysp;
					}
					
					instance_create(PosX, PosY, DustExplosion);
					audio_sfx_play(sfxDestroy, false);
				
					// Temporary do not unload the object
					object_set_unload(false);	

					// Increment state
					Timer = 0;
					State++;
				}
			}
			
			// Else act as solid
			else
			{	
				if !IsFalling and floor(Player.PosY) >= floor(y + 16)
				{
					if object_check_touch(TypeHitbox)
					{
						IsFalling  = true;
						Ysp        = -1.5;
						Player.Ysp = -Player.Ysp;
					}
				}
				
				// Do collision
				object_act_solid(true, true, false, false);
			}
		
			// Check if itembox is falling
			if IsFalling
			{
				Ysp  += 0.21875;
				PosY += Ysp;
			
				// Check for floor
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
			
			CardX = x;
			CardY = y - 3;
		}
		break;
		case 1:
		{
			if (++Timer) == 12
			{
				animation_set(spr_obj_itembox_destroyed, 0);
			}
			
			// Move item card
			CardSpeed = max(CardSpeed - 0.09375, 0);
			CardY	 -= CardSpeed;
			
			// If itemcard is moving, exit
			if CardSpeed 
			{
				break;
			}
			
			// Increment state
			Timer  = 30;
			State += 1;
			
			// Give bonus
			switch BoxType
			{
				case "10 Rings":
				{
					Player.Rings += 10;	
					
					audio_sfx_play(Player.Rings mod 2 == 0 ? sfxRingLeft : sfxRingRight, false);
				}
				break;
				case "High Speed":
				{
					if !Player.SuperState
					{
						audio_bgm_play(TypePrimary, HighSpeed);
					}
					Player.HighspeedBonus = 1200;
				}
				break;
				case "Invincibility":
				{
					if Player.SuperState
					{
						break;
					}
					if !Player.InvincibleBonus
					{
						// Create particles
						for (var i = 0; i < 8; i++)
						{
							var Object = instance_create(PosX, PosY, InvincibilityStar);
							Object.ID  = i;
						}
					}
					Player.InvincibleBonus = 1200;
					
					audio_bgm_play(TypePrimary, Invincibility);
				}
				break;
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
						animation_play(spr_obj_barrier_normal, 4, 0);
					}
					audio_sfx_play(sfxBarrier, false);
				}
				break;
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
				case "Extra Life":
				{
					Player.Lives++;
					audio_bgm_play(TypeSecondary, ExtraLife);
				}
				break;
				case "Eggman":
				{
					player_damage(false, false, false);
				}
				break;
			}
		}
		break;
		case 2:
		{
			// Display the item card for 30 frames
			if !(--Timer)
			{
				State++;
			}
			object_set_unload(TypePause);
		}
		break;
	}
}