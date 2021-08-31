function ContinueScreenProcess()
{
	// Exit if fade is active
	if Countdown == 659 and fade_check(FadeActive)
	{
		exit;
	}
	
	// Idle
	if !RoomState
	{
		// Animate character
		var  SpriteSpeed = CharSpeed[0];
		with CharObject 
		{
			animation_play(sprite_index, SpriteSpeed, 0);
		}
		
		// Check if player can react
		if Countdown >= 60
		{	
			// Set timer frame
			var Count  = Countdown - 60;
			CountFrame = 9 - Count div 60;
			
			if Input.StartPress or Input.ABCPress
			{	
				RoomState++;
				audio_sfx_play(sfxCharge, false);
			}
		}
		
		// Check if player can't react anymore
		else
		{
			CountFrame = 10;
			
			// If timer ran out, go back to devmenu
			if Countdown == 0
			{
				fade_perform(FadeTo, ColourBlack, 1);
				
				// Override save file if not in "no save" mode
				if Game.ActiveSave != -1
				{
					gamedata_save(Game.ActiveSave, Game.Character, Game.CurrentStage[0], Game.Emeralds, 3, 0, 0, Game.SaveState);
				}
			}
			if fade_check(FadeMax)
			{
				room_goto(DevMenu);
			}
		}
		
		// Decrease timer value
		Countdown--;
	}
	
	// Move character
	else if RoomState == 1
	{
		// Animate character
		CharSpeed[1]    = min(CharSpeed[1] + 0.125, 8);
		var SpriteTime  = round(max(1, 8 - abs(CharSpeed[1])));
		
		var ActionSprite = CharSprite[1];
		with CharObject 
		{
			animation_play(ActionSprite, SpriteTime, 11);
		}
		
		// Flick continue object while charging
		if CharSpeed[1] != 8
		{
			ContObject[Game.Continues - 1].visible = !ContObject[Game.Continues - 1].visible;
		}
		
		// When full charged
		else 
		{
			// Shift continue objects for 11 frames
			if (++RoomTimer) < 11
			{
				for (var i = 0; i < Game.Continues; i++)
				{
					ContObject[i].x++;
				}
			}
			
			// Accelerate character
			CharObject.x += 16;
			
			// If object 64 pixels off-screen, increment room state
			if CharObject.x - Game.Width >= 64
			{
				RoomState++;
				fade_perform(FadeTo, ColourBlack, 1);
			}
		}
	}
	
	// Return to the stage
	else if RoomState == 2 and fade_check(FadeMax)
	{
		// Update game data
		Game.Continues--;
		Game.Lives = 3;
		Game.Score = 0;
			
		// Overwrite savedata if not playing in 'no save' slot
		if Game.ActiveSave != -1
		{
			gamedata_save(Game.ActiveSave, Game.Character, Game.CurrentStage[0], Game.Emeralds, 3, 0, 0, Game.SaveState);
		}
			
		// Load into the room
		room_goto(Game.CurrentStage[1]);
	}
}