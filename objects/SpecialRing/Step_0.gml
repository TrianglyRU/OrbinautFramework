/// @description Insert description here
// You can write your code in this editor
	
	// Trigger ring to appear
	if !State
	{
		// Update Special Rings data
		if !array_equals(Game.SpecialRingIDs, [])
		{
			for (var i = 0; i < array_length(Game.SpecialRingIDs); i++)
			{
				if id == Game.SpecialRingIDs[i]
				{
					instance_destroy();
				}
			}
		}
		
		if distance_to_point(Player.PosX, Player.PosY) < 128
		{
			State = 1;
		}
	}
	else if State == 1
	{
		// Play animation
		var Frame = image_index
		if  Frame < 5
		{
			var Duration = 4;
		}
		else
		{
			var Duration = 8;
		}
		animation_play(spr_obj_specialring, Duration, 9);
		
		// Check for overlap
		if image_index >= 8 and object_check_overlap(Triggerbox)
		{	
			// Play sound and destroy object
			audio_sfx_play(sfxSpecialRing, false);
					
			// Check if we do not have 7 emeralds
			if Game.Emeralds != 7
			{
				Input.IgnoreInput	  = true;
				Player.AllowCollision = false;
		
				// Remember position and time
				Game.SpecialRingData[0] = x;
				Game.SpecialRingData[1] = y;
				Game.SpecialRingData[2] = Stage.Time;
				
				Game.Score		   = Player.Score;
				Game.StageBoundary = Stage.BottomBoundary;

				// Remember this ring
				if !array_equals(Game.SpecialRingIDs, [])
				{
					Game.SpecialRingIDs[array_length(Game.SpecialRingIDs)] = id;
				}
				else
				{
					Game.SpecialRingIDs[0] = id;
				}
				
				// If Tails, remove tails object and stop sounds
				if Game.Character == CharTails
				{
					instance_destroy(TailsObject);
					audio_sfx_stop(sfxTired);
					audio_sfx_stop(sfxFlying);
				}
				
				// Create flash object
				instance_create(x, y, SpecialRingFlash);
				image_index	= 0;
				State       = 2;
			}
			
			// Else give 50 rings
			else
			{
				instance_destroy();
				Player.Rings += 50;
			}
		}
	}
	
	// Check if we should trasnfer to the special stage
	else if State == 2
	{
		// Stop player
		with Player
		{
			Xsp		= 0;
			Ysp		= 0;
			visible = 0;
		}
		
		// Load into special stage
		if (++Timer) == 32
		{
			audio_play_sound(sfxSpecialWarp, 0, false);
			fade_perform(FadeTo, ColourWhite, 1);
		}
	}