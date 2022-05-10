/// @description Main
// You can write your code in this editor
	
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
	
	// Destroy if above the water level or collected
	if y < Stage.WaterLevel or Collected
	{
		if sprite_index != spr_obj_bubble_disappear
		{
			if image_index == 6
			{
				animation_play(spr_obj_bubble_disappear, 6, 3);
			}
			else
			{
				instance_destroy();
			}
		}
		else if image_index == 3
		{
			instance_destroy();
		}
	}
	else
	{
		// Lockthe  animation on a certain frame for small and medium bubbles
		if BubbleType < 2
		{
			var TargetFrame = 2 + BubbleType * 2;
			if  image_index >= TargetFrame
			{
				animation_set(sprite_index, TargetFrame);
			}
		}
		
		// Move the bubble
		FinalX = PosX + Stage.WobbleData[WobbleOffset];	
		PosY  += Ysp;
		
		x = floor(FinalX);
		y = floor(PosY);
	}
	
	// If bubble is the large one, be collected by the player
	if BubbleType == 2 and Player.BarrierType != BarrierWater
	{
		if image_index == 6 and object_check_player(ColTrigger)
		{
			// Restore music
			if Player.AirTimer <= 720
			{
				if !Player.SuperState
				{
					if Player.InvincibleBonus
					{
						audio_bgm_play(AudioPrimary, Invincibility);
					}
					else if Player.HighspeedBonus
					{
						audio_bgm_play(AudioPrimary, HighSpeed);
					}
					else
					{
						audio_bgm_play(AudioPrimary, Stage.StageMusic);
					}
				}
				else
				{
					audio_bgm_play(AudioPrimary, SuperTheme);
				}
			}
			
			if Player.Spinning
			{
				Player.RadiusX = Player.DefaultRadiusX;
				Player.RadiusY = Player.DefaultRadiusY;
			}
			if !Player.FlightState and Player.GlideState != GlideAir
			{
				Player.Animation = AnimBreathe;
			}
			Player.AirTimer   = 1800;
			Player.GroundLock = 35;
			Player.Xsp		  = 0;
			Player.Ysp		  = 0;
			Player.Gsp		  = 0;	
			Player.Jumping    = false;
			Player.Spinning	  = false;
			
			audio_sfx_play(sfxBreathe, false);
			
			// Set flag
			Collected = true;
		}
	}