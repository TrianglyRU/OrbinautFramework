function ObjItemBoxMain()
{
	// Check if itembox is not destoryed
	if !Destroyed
	{
		// Play animation
		animation_play(spr_obj_itembox, 4, 0);		
		
		// Blink item card
		if !CardTimer
		{
			CardTimer = 5;
		}
		else
		{	
			CardTimer--;
		} 
		
		// Check if player is spinning or gliding
		if (Player.Spinning or Player.GlideState == GlideAir or Player.GlideState == GlideGround) and Player.OnObject != id
		{
			// Check if player is able to destroy the itembox
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
			
			// Destroy on overlap
			if Check
			{
				if object_check_overlap(Hitbox)
				{
					// Inverse player's speed
					if !Player.Grounded
					{
						Player.Ysp = -Player.Ysp;
					}
					
					// Create explosion
					instance_create(PosX, PosY, DustExplosion);
					audio_sfx_play(sfxDestroy, false);
				
					// Temporary do not unload itembox
					object_set_range(RangeFar, false);	
					
					// Set flags
					Destroyed = true;
					CardTimer = 31;	
					CardPosX  = x;
					CardPosY  = y - 4;
				}
			}
			else
			{
				// Check for bumping into its bottom
				if !Airborne
				{
					if floor(Player.PosY) >= floor(y + 16) and object_check_overlap(Hitbox)
					{
						// Bounce itembox up
						Airborne   = true;
						Ysp        = -1.5;
						Player.Ysp = -Player.Ysp;
					}
				}
				
				// Do collision if can't destroy just yet
				object_act_solid(true, true, false, false);
			}
		}	
		
		// Do collision if can't destroy at all
		else
		{
			object_act_solid(true, true, false, false);
		}

		// Check if itembox is airborne
		if Airborne
		{
			// Move
			Ysp  += 0.21875;
			PosY += Ysp;
			
			// Collide with floor
			var FindFloor = tile_check_collision_v(PosX, PosY + 16, true, false, Player.Layer)[0];
			if  FindFloor < 0
			{
				PosY    += FindFloor;
				Airborne = false;
			}
			
			// Update position
			x = floor(PosX);
			y = floor(PosY);
		}	
	}
	else
	{
		// Play destroyed animation
		animation_play(spr_obj_itembox_destroyed, 1, 0);
		
		// If card timer ran out, allow unload
		if !CardTimer
		{
			object_set_range(RangeClose, TypeUnload);
		}
		else
		{
			// Move item card
			CardSpeed = min(0, CardSpeed + 0.09375);
			CardPosY += CardSpeed;
			
			// Give bonus
			if CardSpeed == 0 and (--CardTimer) == 30
			{
				switch BoxType
				{
					case "10 Rings":
					{
						// Give 10 rings
						Player.Rings += 10;
						
						// Grant extra life
						if Player.Rings >= 100 and Player.LivesRewards == 0
						or Player.Rings >= 200 and Player.LivesRewards == 1
						{
							Player.Lives++;
							Player.LivesRewards++;
							
							// Play jungle
							audio_bgm_play(PriorityHigh, ExtraLifeJingle, noone);
						}
						
						// Play sound
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
							audio_bgm_play(PriorityLow, HighspeedMusic, noone);
						}
					}
					break;
					case "Invincibility":
					{
						if !Player.SuperState
						{
							// Give invincibility bonus for 20 seconds if not in super form
							Player.InvincibleBonus = 1200;
						
							// Play music
							audio_bgm_play(PriorityLow, InvincibleMusic, noone);
						}
					}
					break;
					case "Barrier":
					{
						// Give normal barrier
						Player.BarrierType = BarrierNormal;
						
						// Spawn barrier object
						if !instance_exists(Barrier)
						{
							var  Object = instance_create(Player.PosX, Player.PosY, Barrier);
							with Object
							{
								sprite_index = spr_obj_barrier_normal;
							}
						}
						else with Barrier
						{
							sprite_index = spr_obj_barrier_normal;
						}
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
							var  Object = instance_create(Player.PosX, Player.PosY, Barrier);
							with Object
							{
								sprite_index = spr_obj_barrier_flame;
							}
						}
						else with Barrier
						{
							sprite_index = spr_obj_barrier_flame;
						}
						audio_sfx_play(sfxFlameBarrier, false);
					}
					break;
					case "Thunder Barrier":
					{
						// Give thunder barrier
						Player.BarrierType = BarrierThunder;
						audio_sfx_play(sfxThunderBarrier, false);
						
						// Spawn barrier object
						if !instance_exists(Barrier)
						{
							var  Object = instance_create(Player.PosX, Player.PosY, Barrier);
							with Object
							{
								sprite_index = spr_obj_barrier_thunder;
							}
						}
						else with Barrier
						{
							sprite_index = spr_obj_barrier_thunder;
						}
					}
					break;
					case "Water Barrier":
					{
						// Give water barrier
						Player.BarrierType = BarrierWater;	
						
						// Spawn barrier object
						if !instance_exists(Barrier)
						{
							var  Object = instance_create(Player.PosX, Player.PosY, Barrier);
							with Object
							{
								sprite_index = spr_obj_barrier_water;
							}
						}
						else with Barrier
						{
							sprite_index = spr_obj_barrier_water;
						}
						audio_sfx_play(sfxWaterBarrier, false);
						
						// Play previous track if running out of air
						if Player.AirTimer <= 720
						{	
							if !Player.SuperState
							{
								if Player.InvincibleBonus
								{
									audio_bgm_play(PriorityLow, InvincibleMusic, noone);
								}
								else if Player.HighspeedBonus
								{
									audio_bgm_play(PriorityLow, HighspeedMusic, noone);
								}
								else
								{
									audio_bgm_play(PriorityLow, Stage.StageMusic, other);
								}
							}
							else
							{
								audio_bgm_play(PriorityLow, SuperMusic, other);
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
						audio_bgm_play(PriorityHigh, ExtraLifeJingle, noone);
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
		}
	}
}