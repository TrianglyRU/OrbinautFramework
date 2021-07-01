function MenuOptionToggle()
{
	// React to key left and key right
	if Input.RightPress or Input.LeftPress
	{
		if MenuState == AudioVideoConfig
		{
			switch MenuOption
			{				
				// Aspect ratio
				case 0: 
				{	
					Game.ResolutionWidth = Game.ResolutionWidth == 400 ? 530 : 400;
					application_set_size(Game.ResolutionWidth, Game.ResolutionHeight);
					window_set_size(Game.ResolutionWidth * Game.WindowSize, Game.ResolutionHeight * Game.WindowSize);
				}
				break;
				
				// Window size
				case 1:
				{	
					if Input.RightPress
					{
						Game.WindowSize++; 
					}
					else 
					{
						Game.WindowSize--;
					}
					Game.WindowSize = loop_value(Game.WindowSize, 1, 5);
					window_set_size(Game.ResolutionWidth * Game.WindowSize, Game.ResolutionHeight * Game.WindowSize);
				}
				break;
				
				// Fullscreen toggle
				case 2: 
				{	
					Game.WindowFullscreen = !Game.WindowFullscreen;
					window_set_fullscreen(Game.WindowFullscreen);
				}	
				break;
				
				// Music volume
				case 3: 
				{	
					if Input.RightPress
					{
						Game.MusicVolume += 0.1;
					}
					else 
					{
						Game.MusicVolume -= 0.1;
					}
					Game.MusicVolume = loop_value(round(Game.MusicVolume * 10), 0, 11) / 10;
				}
				break;
				
				// Sound volume
				case 4: 
				{	
					if Input.RightPress
					{
						Game.SoundVolume += 0.1;
					}
					else 
					{
						Game.SoundVolume -= 0.1;
					}
					Game.SoundVolume = loop_value(round(Game.SoundVolume * 10), 0, 11) / 10;
				}	
				break;
			}
		} 
		else if MenuState == FrameworkConfig
		{
			switch MenuOption
			{
				case 0: Game.SpindashEnabled   = !Game.SpindashEnabled;   break;
				case 1: Game.DropdashEnabled   = !Game.DropdashEnabled;   break; 
				case 2: Game.PeeloutEnabled    = !Game.PeeloutEnabled;    break;
				case 3: Game.GroundSpeedcap    = !Game.GroundSpeedcap;    break;
				case 4: Game.AirSpeedcap       = !Game.AirSpeedcap;       break;
				case 5: Game.RolljumpControl   = !Game.RolljumpControl;   break;
				case 6: Game.AllowUnroll       = !Game.AllowUnroll;	      break;
				case 7: Game.ExtendedCamera	   = !Game.ExtendedCamera;    break;
				case 8: Game.OriginalRollLimit = !Game.OriginalRollLimit; break;
				case 9: Game.FlyingCancel      = !Game.FlyingCancel;      break;
			}
		}
	}
}