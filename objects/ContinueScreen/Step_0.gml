/// @description Main
// You can write your code in this editor
	
	if !fade_check(StateActive)
	{
		Renderer.UpdateAnimations = true;
	}
	else
	{
		Renderer.UpdateAnimations = false;
	}
	if Countdown == 659 and fade_check(StateActive)
	{
		return;
	}

	switch State
	{
		// Wait for input
		case 0:
		{
			if (Countdown--) > 0
			{	
				if Input.StartPress or Input.ABCPress
				{	
					// Update player
					with CharObject 
					{
						animation_play(ContinueScreen.CharSprite[1], 8, 0);
					}
					audio_sfx_play(sfxCharge, false);
					
					// Stop animation of the continue icon
					with ContObject[global.Continues - 1]
					{
						animation_set(sprite_index, image_index);
					}
					
					// Increment state
					AnimationState = 0;
					State		  += 1;
				}
				
				// Update countdown frame
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
					fade_perform(ModeInto, BlendBlack, 1);
				}
				else if fade_check(StateMax)
				{
					if global.ActiveSave != -1
					{
						global.Lives     = 3;
						global.Score     = 0;
						global.Continues = 0;
				
						savedata_save(global.ActiveSave);
					}
					room_goto(Screen_DevMenu);
				}
			}
		}
		break;
		
		// React
		case 1:
		{
			// Increse animation speed
			CharSpeed[1] = min(CharSpeed[1] + 0.125, 8);
			
			// Animate character
			if CharSpeed[1] < 6
			{
				var Sprite = CharSprite[2];
			}
			else if CharSpeed[1] < 8 or array_length(CharSprite) < 5
			{
				var Sprite = CharSprite[3];
			}
			else
			{
				var Sprite = CharSprite[4];
			}
			var Speed = floor(max(1, 9 - abs(CharSpeed[1]))); 
			
			// Switch to running animation once idle animation switches to its second frame
			switch AnimationState
			{
				case 0:
				{
					if CharObject.image_index != 1
					{
						break;
					}
					
					// Fallthrough to case 1 (no break)
					AnimationState = 1;
				}
				case 1:
					with CharObject animation_play(Sprite, Speed, 0);
				break;
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
					fade_perform(ModeInto, BlendBlack, 1);
					audio_bgm_stop(AudioPrimary, 0.5);
					
					// Increment state
					State++;
				}
			}
		}
		break;
		
		// Load back into the stage
		case 2:
		{
			if fade_check(StateMax)
			{
				global.Continues -= 1;
				global.Lives	  = 3;
				global.Score	  = 0;
			
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