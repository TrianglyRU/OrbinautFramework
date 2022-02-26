function ContinueScreenProcess()
{
	if Countdown == 659 and fade_check(StateActive)
	{
		return;
	}

	switch State
	{
		case 0:
		{
			if (Countdown--) > 0
			{	
				if !fade_check(StateActive)
				{
					Renderer.UpdateAnimations = true;
				}
				if Input.StartPress or Input.ABCPress
				{	
					audio_sfx_play(sfxCharge, false);
					
					// Increment state
					State++;
				}
				
				if Countdown > 60
				{
					CountFrame = 9 - (Countdown - 60) div 60;
				}
				else
				{
					CountFrame = 10;
				}
			}
			else
			{
				// Return back to DevMenu
				if !fade_check(StateActive)
				{
					if global.ActiveSave != -1
					{
						global.Lives     = 3;
						global.Score     = 0;
						global.Continues = 0;
				
						savedata_save(global.ActiveSave);
					}
					fade_perform(ModeInto, BlendBlack, 1);
					
					Renderer.UpdateAnimations = false;
				}
				else if fade_check(StateMax)
				{
					room_goto(Screen_DevMenu);
				}
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
				animation_play(SpriteData[0], SpriteData[1], 11);
			}
		
			// Flick continue object while charging
			if CharSpeed[1] != 8
			{
				ContObject[global.Continues - 1].visible = !ContObject[global.Continues - 1].visible;
			}
			else 
			{
				// Shift continue objects
				if (++RoomTimer) < 11
				{
					for (var i = 0; i < global.Continues; i++)
					{
						ContObject[i].x++;
					}
				}
			
				// If character is 64 pixels off-screen, increment state
				CharObject.x += 16; if CharObject.x - global.Width >= 64
				{
					State++;
					
					fade_perform(ModeInto, BlendBlack, 1);
					audio_bgm_stop(TypePrimary, 0.5);
					
					Renderer.UpdateAnimations = false;
				}
			}
		}
		break;
		case 2:
		{
			if fade_check(StateMax)
			{
				global.Continues--;
				global.Lives = 3;
				global.Score = 0;
			
				// Overwrite savedata if not playing in 'no save' slot
				if global.ActiveSave != -1
				{
					savedata_save(global.ActiveSave);
				}
			
				// Head back to our stage
				room_goto(global.StageRoom);
			}
		}
		break;
	}
}