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
				animation_play(spr_obj_bubble_disappear, 6, 3);
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
		// Lock animation on certain frame for small and medium bubbles
		if BubbleType < 2
		{
			var TargetFrame = 2 + BubbleType * 2;
			if  image_index >= TargetFrame
			{
				animation_set(sprite_index, TargetFrame);
			}
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