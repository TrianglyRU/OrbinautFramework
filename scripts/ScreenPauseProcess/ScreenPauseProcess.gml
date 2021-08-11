function ScreenPauseProcess()
{	
	if Stage.IsPaused
	{
		var MenuX = Width / 2;
		var MenuY = Height / 2;
		draw_sprite(spr_pause_menu, sign(PauseValue[1]), MenuX, MenuY);
		draw_sprite(spr_pause_buttons, PauseValue[0] + (PauseValue[1] ? 3 : 0), MenuX, MenuY);
		
		if Input.DownPress
		{
			PauseValue[0] = loop_value(PauseValue[0] + 1, 0, PauseValue[1] ? 2 : 3);
		}
		else if Input.UpPress
		{
			PauseValue[0] = loop_value(PauseValue[0] - 1, 0, PauseValue[1] ? 2 : 3);
		}
	
		if Input.StartPress or Input.ABCPress
		{
			Input.StartPress = false;
			Input.ABCPress   = false;
			
			if PauseValue[1]
			{
				if PauseValue[0]
				{
					PauseValue[1] = 0;
					PauseValue[0] = 0;
				}
				else
				{
					audio_stop_all();
					
					if PauseValue[1] == 1
					{
						room_restart();
					}
					else 
					{
						Game.CheckpointID   = false;
						Game.PlayerPosition = false;
						Game.Time			= 0;
						Game.StageBoundary  = 0;
						Game.Score		    = 0;
						
						room_goto(DevMenu);
					}
				}
			}
			else
			{
				switch PauseValue[0]
				{
					case 0:
					{
						audio_resume_all();
						
						Stage.IsPaused = false;
						CameraEnabled  = true;
						
						instance_activate_region(CameraX - 240, CameraY - 256, Width + 480, Height + 512, true);
					}
					break;
					case 1: 
					{
						PauseValue[1] = 1;
						PauseValue[0] = 0;
					}
					break;
					case 2: 
					{
						PauseValue[1] = 2;
						PauseValue[0] = 0;
					}
					break;
				}
			}
		}
	}
	else if Stage.DoUpdate and Input.StartPress
	{
		Stage.IsPaused	 = true;
		Input.StartPress = false;
		CameraEnabled    = false;

		audio_pause_all();
	}
}