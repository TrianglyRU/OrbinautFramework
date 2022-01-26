function InterfacePauseProcess()
{
	if Stage.IsPaused
	{	
		// Loop through options
		if Input.DownPress
		{
			PauseValue = loop_value(PauseValue + 1, 0, 3); audio_sfx_play(sfxPauseSwitch, false);
		}
		else if Input.UpPress
		{
			PauseValue = loop_value(PauseValue - 1, 0, 3); audio_sfx_play(sfxPauseSwitch, false);
		}
		
		if !fade_check(StateActive)
		{
			PauseTimer++;
			PauseTimer = PauseTimer mod 16;
			
			// React
			if (Input.StartPress or Input.ABCPress) then switch PauseValue
			{
				// Continue
				case 0:
				{
					Stage.IsPaused        = false;
					Stage.UpdateObjects   = true;
					Stage.TimeEnabled     = true;
					Camera.Enabled        = true;
					Game.UpdateAnimations = true;
					
					instance_activate_range(Camera.ViewX);
					
					audio_resume_all();
					audio_sfx_play(sfxPauseBack, false);
				}
				break;
					
				// Restart
				case 1: 
				{
					if Player.Lives > 1
					{
						fade_perform(ModeInto, BlendBlack, 1);
						audio_sfx_play(sfxPauseSelect, false);
					}
					else
					{
						audio_sfx_play(sfxFail, false);
					}
				}
				break;
					
				// Exit
				case 2: 
				{
					fade_perform(ModeInto, BlendBlack, 1);
					audio_sfx_play(sfxPauseSelect, false);
				}
				break;
			}
		}
		else if fade_check(StateMax)
		{
			// Restart the Stage
			if PauseValue == 1
			{
				Game.Lives -= 1; room_restart();						
			}
					
			// Exit to DevMenu
			else if PauseValue == 2
			{
				Game.SpecialRingList = [];
				Game.StarPostData	 = [];
				
				room_goto(Screen_DevMenu);
			}
		}
	}
	
	// Pause the game
	else if Input.StartPress
	{
		if CardValue[1] == 3 and !Stage.IsFinished and !Player.Death
		{
			Game.UpdateAnimations = false;
			Camera.Enabled        = false;
			Input.StartPress	  = false;
			Stage.UpdateObjects   = false;
			Stage.TimeEnabled     = false;
			Stage.IsPaused	      = true;
			
			audio_pause_all();
			audio_sfx_play(sfxPauseSelect, false);
		}
	}
}