/// @description
// You can write your code in this editor
	
	// Handle wobble data
	if WobbleOffset + 1 == array_length(Stage.WobbleData)
	{
		WobbleOffset = 0;
	}
	else
	{
		WobbleOffset++
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
		}
		
		// Update position
		PosX  = OriginPosX + Stage.WobbleData[WobbleOffset];	
		PosY += Ysp;
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