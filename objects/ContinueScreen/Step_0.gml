/// @description
// You can write your code in this editor
	
	// Exit if palette fade is active
	if !RoomTimer and fade_check(FadeActive)
	{
		exit;
	}
	
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
			if RoomTimer < 120
			{
				RoomTimer++;
			}
			else if RoomTimer == 120
			{
				// Perform fade
				fade_perform(to, black, 1);
				
				// Overwrite savedata if not playing in 'no save' slot
				if Game.ActiveSave != -1
				{
					gamedata_save(Game.ActiveSave, Game.Character, Game.CurrentStage[0], Game.Emeralds, 3, 0, 0);
				}	
				RoomTimer++;
			}
			
			// Goto into devMenu once fade reaches its max step
			if fade_check(FadeMax)
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
			ContObject[Game.Continues - 1].visible = !ContObject[Game.Continues - 1].visible;
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
				RoomState = 2;
				RoomTimer = 1;
				
				// Perform fade
				fade_perform(to, black, 1);
			}
		}
	}
	
	// State 2: unload, return to stage
	else if RoomState == 2
	{
		// Has fade reached its max state?
		if fade_check(FadeMax)
		{
			// Subtract one continue
			Game.Continues--;
			
			// Reset score and lives
			Game.Lives = 3;
			Game.Score = 0;
			
			// Overwrite savedata if not playing in 'no save' slot
			if Game.ActiveSave != -1
			{
				gamedata_save(Game.ActiveSave, Game.Character, Game.CurrentStage[0], Game.Emeralds, 3, 0, 0);
			}
			
			// Go into the previous stage
			room_goto(Game.CurrentStage[1]);
		}	
	}