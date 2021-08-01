/// @description
// You can write your code in this editor
	
	// Exit if palette fade is active
	/*
	if fade_check(true)
	{
		exit;
	}
	*/
	// State 0: idle
	if RoomState == 0
	{
		// Animate character
		with CharObject animation_play(sprite_index, 18, 1);
		
		// Check if timer is active
		if Countdown
		{		
			// Go into next room state
			if Input.StartPress or Input.ABCPress
			{	
				RoomState = 1;
				
				// Play sound
				audio_sfx_play(sfxCharge, false);
			}
			
			// Count down the timer
			else
			{
				Countdown--;
			}
		}
		
		// Check if timer ran out
		else
		{
			// Сount room timer
			RoomTimer++;
			
			// Perform fade
			if RoomTimer == 120
			{
				fade_perform(to, black, 1);
			}

			// Return to devmenu
			else if RoomTimer == 156
			{
				room_goto(DevMenu);
			}
		}
	}
	
	// State 1: react
	else if RoomState == 1
	{
		// Charge character speed (for 64 frames)
		CharSpeed	   = min(CharSpeed + 0.125, 8);
		var SpriteTime = round(max(1, 8 - abs(CharSpeed)));
		
		// Animate character
		with CharObject animation_play(spr_obj_cont_sonic_action, SpriteTime, 12);
		
		// Flick last continue object while charging
		if CharSpeed != 8
		{
			if ContObject[Game.Continues - 1].visible
			{	
				ContObject[Game.Continues - 1].visible = false;
			}
			else
			{
				ContObject[Game.Continues - 1].visible = true;
			}
		}
		
		// When full charged
		else 
		{
			// Count timer
			RoomTimer++
			
			// Shift continue objects for 11 frames
			if RoomTimer < 11
			{
				for (var i = 0; i < Game.Continues; i++)
				{
					ContObject[i].x++;
				}
			}
			
			// Accelerate character
			CharObject.x += 16;
			
			// If object 64 pixels off-screen, go into next room state
			if CharObject.x - room_width >= 64
			{
				RoomTimer = 0;
				RoomState = 2;
			}
		}
	}
	
	// State 2: unload, return to stage
	else if RoomState == 2
	{
		if !RoomTimer
		{
			fade_perform(to, black, 1);
		}
		RoomTimer++;
		
		// Return to devmenu
		if RoomTimer == 36
		{
			room_goto(DevMenu);
		}
	}