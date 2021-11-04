function ContinueScreenProcess()
{
	// Exit if fading in
	if Countdown == 659 and fade_check(FadeActive)
	{
		exit;
	}
	
	// Idle
	switch State
	{
		case 0:
		{
			if (Countdown--) >= 60
			{	
				// Define timer frame
				CountFrame = 9 - (Countdown - 60) div 60;
			
				// React (increment state)
				if Input.StartPress or Input.ABCPress
				{	
					State++;
					audio_sfx_play(sfxCharge, false);
				}
			}
			
			// Return back to devmenu
			else
			{
				if !fade_check(FadeActive)
				{
					// Perform fade
					fade_perform(FadeTo, ColourBlack, 1);
				
					// Overwrite savedata if not playing in 'no save' slot
					if Game.ActiveSave != -1
					{
						Game.Lives     = 3;
						Game.Score     = 0;
						Game.Continues = 0;
				
						gamedata_save(Game.ActiveSave);
					}
				}
				else if fade_check(FadeMax)
				{
					room_goto(Screen_DevMenu);
				}
			
				// Set timer frame to 00
				CountFrame = 10;
			}
		}
		break;
		case 1:
		{
			// Increse animation speed
			CharSpeed[1] = min(CharSpeed[1] + 0.125, 8);
		
			// Animate character
			var SpriteData = [CharSprite[1], round(max(1, 8 - abs(CharSpeed[1])))];
			with CharObject 
			{
				animation_play(SpriteData[0], SpriteData[1], 0, 11);
			}
		
			// Flick continue object while charging
			if CharSpeed[1] != 8
			{
				ContObject[Game.Continues - 1].visible = !ContObject[Game.Continues - 1].visible;
			}
			else 
			{
				// Shift continue objects
				if (++RoomTimer) < 11
				{
					for (var i = 0; i < Game.Continues; i++)
					{
						ContObject[i].x++;
					}
				}
			
				// Accelerate character
				CharObject.x += 16;
			
				// If character is 64 pixels off-screen, increment state
				if CharObject.x - Game.Width >= 64
				{
					State++;
					fade_perform(FadeTo, ColourBlack, 1);
				}
			}
		}
		break;
		case 2:
		{
			if fade_check(FadeMax)
			{
				// Update game data
				Game.Continues--;
				Game.Lives = 3;
				Game.Score = 0;
			
				// Overwrite savedata if not playing in 'no save' slot
				if Game.ActiveSave != -1
				{
					gamedata_save(Game.ActiveSave);
				}
			
				// Load stage
				room_goto(Game.StageRoom);
			}
		}
		break;
	}
}