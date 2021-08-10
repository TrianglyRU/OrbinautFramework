function ObjItemBoxScript()
{
	// Check if itembox is not destoryed
	if !Destroyed
	{
		animation_play(spr_obj_itembox, 4, 1);		
		
		if !CardTimer
		{
			CardTimer = 5;
		}
		else
		{	
			CardTimer--;
		} 
		
		// Can player destroy the itembox?
		if (Player.Jumping or Player.Rolling or Player.GlideState == GlideActive) and Player.Ysp >= 0
		{
			if object_player_overlap(CollisionHitbox)
			{
				if !Player.Grounded
				{
					Player.Ysp = -Player.Ysp;
				}
					
				instance_create(floor(PosX), floor(PosY), DustExplosion);
				audio_sfx_play(sfxDestroy, false);
				
				// Do not unload it
				object_set_range(RangeFar, false);	
				
				CardTimer = 31;	
				Destroyed = true;
			}
		}		
		else
		{
			object_act_solid(true, true, false);
			
			if !Airborne
			{
				if floor(Player.PosY) >= floor(PosY + 16) and object_player_overlap(CollisionHitbox)
				{
					Airborne = true;
					Ysp      = -1.5;
					
					Player.Ysp = -Player.Ysp;
				}
			}
		}

		// Check if monitor is airborne
		if Airborne
		{
			// Update position
			Ysp  += 0.21875;
			PosY += Ysp;
		
			// Do collision with tiles & check if we collided
			var FoundFloorA = object_collide_tiles_v(SideLeft, SideBottom, 0, LayerA)
			var FoundFloorB = object_collide_tiles_v(SideLeft, SideBottom, 0, LayerB)
			
			if  FoundFloorA or FoundFloorB
			{
				Airborne = false;
			}
			
			CardPosX = PosX;
			CardPosY = PosY - 4;
		}	
	}
	
	// Check if monitor is destroyed
	if Destroyed
	{
		// Play destroyed animation
		animation_play(spr_obj_itembox_destroyed, 1, 1);
		
		if !CardTimer
		{
			exit;
		}
		
		CardSpeed = min(0, CardSpeed + 0.09375);
		CardPosY += CardSpeed;
		
		if CardSpeed != 0
		{
			exit;
		}
		
		if CardTimer
		{
			CardTimer--;
			
			if CardTimer == 30
			{
				switch BoxType
				{
					case "10 Rings":
					{
						// Give 10 rings
						Player.Rings += 10;
						
						// Give extra life
						if Player.Rings >= 100 and Player.LivesRewards == 0
						or Player.Rings >= 200 and Player.LivesRewards == 1
						{
							Player.Lives++;
							Player.LivesRewards++;
							audio_bgm_play(PriorityHigh, ExtraLifeJingle, noone);
						}
						
						// Play sound, switch left and right channels every ring
						audio_sfx_play(Player.Rings mod 2 == 0 ? sfxRingLeft : sfxRingRight, false);
					}
					break;
					case "High Speed":
					{
						// Give highspeed bonus for 20 seconds
						Player.HighSpeedBonus = 1200;
						
						// Play music
						if !Player.SuperState
						{
							audio_bgm_play(PriorityLow, HighspeedMusic, noone);
						}
					}
					break;
					case "Regular Barrier":
					{
						Player.BarrierType = BarrierNormal;
						audio_sfx_play(sfxBarrier, false);
						
						// Spawn barrier object
						if !instance_exists(Barrier)
						{
							instance_create(floor(Player.PosX), floor(Player.PosY), Barrier);
						}
					}
					break;
					case "Flame Barrier":
					{
						Player.BarrierType = BarrierFlame;
						audio_sfx_play(sfxFlameBarrier, false);
						
						// Spawn barrier object
						if !instance_exists(Barrier)
						{
							instance_create(floor(Player.PosX), floor(Player.PosY), Barrier);
						}
					}
					break;
					case "Thunder Barrier":
					{
						Player.BarrierType = BarrierThunder;
						audio_sfx_play(sfxThunderBarrier, false);
						
						// Spawn barrier object
						if !instance_exists(Barrier)
						{
							instance_create(floor(Player.PosX), floor(Player.PosY), Barrier);
						}
					}
					break;
					case "Water Barrier":
					{
						Player.BarrierType = BarrierWater;
						audio_sfx_play(sfxWaterBarrier, false);
						
						// Spawn barrier object
						if !instance_exists(Barrier)
						{
							instance_create(floor(Player.PosX), floor(Player.PosY), Barrier);
						}
					}
					break;
					case "Invincibility":
					{
						if !Player.SuperState
						{
							// Give invincibility bonus for 20 seconds
							Player.InvincibilityBonus = 1200;
						
							// Play music
							audio_bgm_play(PriorityLow, InvincibilityMusic, noone);
						}
					}
					break;
					case "Extra Life":
					{
						// Give player 1 extra life
						Player.Lives += 1;
						
						// Play jingle
						audio_bgm_play(PriorityHigh, ExtraLifeJingle, noone);
					}
					break;
					case "Eggman":
					{
						object_damage(false, false, false);
					}
					break;
				}
			}
		}
		else
		{
			// Allow unload
			object_set_range(RangeFar, ResetUnload);
		}
	}
}