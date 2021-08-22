function ObjBubbleMain()
{
	// Handle wobble data
	if Direction = FlipRight
	{
		if WobbleOffset + 1 == array_length(Stage.WobbleData)
		{
			WobbleOffset = 0;
		}
		else
		{
			WobbleOffset++
		}
	}
	else if Direction = FlipLeft
	{
		if !WobbleOffset
		{
			WobbleOffset = array_length(Stage.WobbleData) - 1;
		}
		else
		{
			WobbleOffset--
		}
	}
	
	// Destroy when out of water
	if y < Stage.WaterLevel or Collected
	{
		if BubbleType == 2
		{
			animation_play(spr_obj_bubble_disappear, 6, 3);
			
			// Destroy on animation end
			if image_index == 3
			{
				instance_destroy();
			}
		}
		else
		{
			instance_destroy();
		}
	}
	else
	{
		// Play animation
		switch BubbleType
		{
			case 0:
				animation_play(spr_obj_bubble_small, 15, 2);
			break;
			case 1:
				animation_play(spr_obj_bubble_medium, 15, 3);
			break;
			case 2:
				animation_play(spr_obj_bubble_large, 15, 4);
			break;
			case 3:
			{
				var Frame = image_index;
				if  Frame < 4
				{
					var Duration = 7;
				}
				else if Frame < 6
				{
					var Duration = 6;
				}
				else
				{
					var Duration = 8;
				}
				if Frame < 12 and Player.IsUnderwater
				{
					animation_play(sprite_index, Duration, 12);
				}
				else
				{
					instance_destroy();
				}
			}
			break;
		}
		
		// Move bubble	
		FinalX = PosX + Stage.WobbleData[WobbleOffset];	
		PosY  += Ysp;
		
		// Update position
		object_update_position(FinalX, PosY);
	}
	
	// If bubble is the large one, be collected by the player
	if BubbleType == 2 and Player.BarrierType != BarrierWater
	{
		if image_index == 4 and object_check_overlap(Triggerbox)
		{
			// Restore music
			if Player.AirTimer <= 720
			{
				if !Player.SuperState
				{
					if Player.HighspeedBonus
					{
						audio_bgm_play(PriorityLow, HighspeedMusic, noone);
					}
					else if Player.InvincibleBonus
					{
						audio_bgm_play(PriorityLow, InvincibilityMusic, noone);
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
			
			// Reset collision radiuses
			if Player.Spinning
			{
				Player.RadiusX = Player.DefaultRadiusX;
				Player.RadiusY = Player.DefaultRadiusY;
			}
			
			// Reset flags
			Player.AirTimer     = 1800;
			Player.GroundLock = 35;
			Player.Xsp		    = 0;
			Player.Ysp		    = 0;
			Player.Inertia	    = 0;	
			Player.Jumping      = false;
			Player.Spinning	    = false;
			
			// Play animation
			if !Player.FlightState and Player.GlideState != GlideActive
			{
				Player.Animation = AnimBreathe;
			}
			
			// Set bubble flag
			Collected = true;
			
			// Play sound
			audio_sfx_play(sfxBreathe, false);
		}
	}
}