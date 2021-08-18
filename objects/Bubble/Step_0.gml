/// @description
// You can write your code in this editor
	
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
	if floor(PosY) < Stage.WaterLevel or Collected
	{
		if BubbleType == 2
		{
			animation_play(spr_obj_bubble_disappear, 6, 4);
			if animation_get_frame(id) == 4
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
				animation_play(spr_obj_bubble_small, 15, 3);
			break;
			case 1:
				animation_play(spr_obj_bubble_medium, 15, 4);
			break;
			case 2:
				animation_play(spr_obj_bubble_large, 15, 5);
			break;
			case 3:
			{
				var Frame = animation_get_frame(id);
				if  Frame < 5
				{
					var Duration = 7;
				}
				else if Frame < 7
				{
					var Duration = 6;
				}
				else
				{
					var Duration = 8;
				}
				if Frame < 13 and Player.IsUnderwater
				{
					animation_play(sprite_index, Duration, 13);
				}
				else
				{
					instance_destroy();
				}
			}
			break;
		}
		
		// Move bubble
		if BubbleType == 3
		{
			if animation_get_frame(id) < 5
			{
				FinalX = PosX + Stage.WobbleData[WobbleOffset];	
				PosY  += Ysp;
			}
			else if !ScreenPosition
			{
				ScreenPosition[0] = floor(FinalX);
				ScreenPosition[1] = floor(PosY);
				FinalX += Player.Xsp;
				PosY   += Player.Ysp;
			}
		}
		else
		{		
			FinalX = PosX + Stage.WobbleData[WobbleOffset];	
			PosY  += Ysp;
		}
		
		// Update position
		object_update_position(FinalX, PosY);
	}
	
	// If bubble is large, be collected by a player
	if BubbleType == 2
	{
		if animation_get_frame(id) == 5 and object_player_overlap(Triggerbox)
		{
			// Music stuff
			if Player.AirTimer <= 720
			{
				if !Player.SuperState
				{
					if Player.HighSpeedBonus
					{
						audio_bgm_play(PriorityLow, HighspeedMusic, noone);
					}
					else if Player.InvincibilityBonus
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
			
			// Reset flags
			if Player.Spinning
			{
				Player.RadiusX = Player.DefaultRadiusX;
				Player.RadiusY = Player.DefaultRadiusY;
			}
			Player.AirTimer     = 1800;
			Player.MovementLock = 35;
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