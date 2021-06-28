/// @description Pause
// You can write your code in this editor
	
	if GamePaused
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
					if (PauseMode = 1) room_restart();
					else room_goto(DevMenu);
				}
			}
			else
			{
				switch PauseButton
				{
					case 0:
						GamePaused = false;
						//instance_activate_object(UnloadFar);
						//instance_activate_object(UnloadClose);
						
						// Do code from object side
						with all
						{
							// Exit the code if object is the one to ignore
							var IgnoreList = [Framework, Player, Input, Screen, Stage, Discord, Spawnpoint];
							for (var i = 0; i < array_length(IgnoreList); i++)
							{
								if object_index == IgnoreList[i]
								{
									exit;
								}
							}	
							instance_activate_object(self);
						}
						
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