/// @description Insert description here
// You can write your code in this editor
	
	// Trigger ring to appear
	if !State and distance_to_point(Player.PosX, Player.PosY) < 128
	{
		State = 1;
	}
	else if State == 1
	{
		// If ring's size is not the default one, increase
		if image_xscale < 1
		{
			image_xscale += 0.025;
			image_yscale += 0.025;
		}
		
		// Check for overlap
		else if object_player_overlap(Hitbox)
		{	
			// Play sound and destroy object
			audio_sfx_play(sfxSpecialRing, false);
			instance_destroy();
			
			// Check if we do not have 7 emeralds
			if Game.Emeralds != 7
			{
				Input.IgnoreInput	  = true;
				Player.AllowCollision = false;
		
				// Remember position
				Game.PlayerPosition[0] = x;
				Game.PlayerPosition[1] = y;
		
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
			}
			
			// Else give 50 rings
			else
			{
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
			fade_perform(FadeTo, FadeWhite, 1);
		}
		if fade_check(FadeMax)
		{
			room_goto(SpecialMainRoom);
		}
	}
	
	// Play animation
	animation_play(spr_obj_specialring, 8, 1);