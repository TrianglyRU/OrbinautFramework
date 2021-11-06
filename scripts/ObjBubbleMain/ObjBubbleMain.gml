function ObjBubbleMain()
{
	// Handle wobble data
	if Direction == FlipRight
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
	else if Direction == FlipLeft
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
		if sprite_index != spr_obj_bubble_disappear
		{
			// If reached last frame possible, pop the bubble
			if image_index == 6
			{
				// Update animation
				animation_play(spr_obj_bubble_disappear, 6, 0, 3);
			}
			
			// Else destroy instantly
			else
			{
				instance_destroy();
			}
		}
		
		// Destroy on animation end
		else if image_index == 3
		{
			instance_destroy();
		}
	}
	else
	{
		// Set animation
		switch BubbleType
		{
			case 0:
			{
				if image_index == 2
				{
					animation_set(sprite_index, 2);
				}
				else
				{
					animation_play(sprite_index, 15, 0, 2);
				}
			}
			break;
			case 1:
			{
				if image_index == 4
				{
					animation_set(sprite_index, 4);
				}
				else
				{
					animation_play(sprite_index, 15, 1, 4);
				}
			}
			break;
			case 2:
			{
				animation_play(sprite_index, 15, 2, 6);
			}
			break;
		}
		
		// Move bubble	
		FinalX = PosX + Stage.WobbleData[WobbleOffset];	
		PosY  += Ysp;
		
		// Update position
		x = floor(FinalX);
		y = floor(PosY);
	}
	
	// If bubble is the large one, be collected by the player
	if BubbleType == 2 and Player.BarrierType != BarrierWater
	{
		if image_index == 6 and object_check_overlap(TypeTrigger)
		{
			// Restore music
			if Player.AirTimer <= 720
			{
				if !Player.SuperState
				{
					if Player.InvincibleBonus
					{
						audio_bgm_play(PriorityLow, Invincibility, other, other);
					}
					else if Player.HighspeedBonus
					{
						audio_bgm_play(PriorityLow, HighSpeed, other, other);
					}
					else
					{
						audio_bgm_play(PriorityLow, Stage.StageMusic, other, other);
					}
				}
				else
				{
					audio_bgm_play(PriorityLow, SuperTheme, other, other);
				}
			}
			
			// Reset collision radiuses
			if Player.Spinning
			{
				Player.RadiusX = Player.DefaultRadiusX;
				Player.RadiusY = Player.DefaultRadiusY;
			}
			
			// Reset flags
			Player.AirTimer   = 1800;
			Player.GroundLock = 35;
			Player.Xsp		  = 0;
			Player.Ysp		  = 0;
			Player.Inertia	  = 0;	
			Player.Jumping    = false;
			Player.Spinning	  = false;
			
			// Play animation
			if !Player.FlightState and Player.GlideState != GlideAir
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