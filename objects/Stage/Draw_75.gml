/// @description Stage Pause
// You can write your code in this editor
	
	if IsPaused
	{	
		if Input.DownPress
		{
			PauseButton = loop_value(PauseButton + 1, 0, PauseMode ? 2 : 3);
		}
		else if Input.UpPress
		{
			PauseButton = loop_value(PauseButton - 1, 0, PauseMode ? 2 : 3);
		}
	
		if Input.StartPress or Input.ABCPress
		{
			Input.StartPress = false;
			Input.ABCPress = false;
			
			if PauseMode
			{
				if PauseButton
				{
					PauseMode = 0;
					PauseButton = 0;
				}
				else
				{
					audio_stop_all();
					
					if PauseMode == 1
					{
						room_restart();
					}
					else 
					{
						Game.CheckpointID = false;
						Game.PlayerPosition = false;
						Game.Time = 0;
						Game.StageBoundary = 0;
						Game.Score = 0;
						//Game.PaletteIndexDry[0] = 0;
						room_goto(DevMenu);
					}
				}
			}
			else
			{
				switch PauseButton
				{
					case 0:
					
						audio_resume_all();
						
						IsPaused = false;
						
						Screen.CameraEnabled = true;
						
						// Activate all objects
						instance_activate_region(Screen.CameraX - 240, Screen.CameraY - 256, Screen.Width + 480, Screen.Height + 512, true);
						
						sprite_delete(Screen.PauseSurface);
						Screen.PauseSurface = -1;
					break;
					case 1: 
						PauseMode = 1;
						PauseButton = 0;
					break;
					case 2: 
						PauseMode = 2;
						PauseButton = 0;
					break;
				}
			}
		}
	}
	else if Input.StartPress
	{
		IsPaused = true;
		Input.StartPress     = false;
		Screen.CameraEnabled = false;
		Screen.PauseSurface  = sprite_create_from_surface(application_surface, 0, 0, Game.ResolutionWidth, Game.ResolutionHeight, false, false, 0, 0);

		audio_pause_all();
	
		var IgnoreList = [Framework, Player, Input, Screen, Stage, Discord, Spawnpoint, Palette];
		var Len = array_length(IgnoreList);
		
		// Do code from object side
		/*with all
		{
			// Exit the code if object is the one to ignore
			for (var i = 0; i < Len; i++)
			{
				if object_index == IgnoreList[i] exit;
			}
			instance_deactivate_object(self);
		}*/
	}