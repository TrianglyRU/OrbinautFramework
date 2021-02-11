/// @description Navigation
// You can write your code in this editor
	
	if (TextTimer < 60) TextTimer++;
	if (TextPrint < 40) TextPrint++;
	if (MainTimer < 60) MainTimer++;
	if (MainPrint < 40) MainPrint++;
	
	// Disable fade
	Game.FadeEnabled = false;
	
	// Navigate between options
	if (Input.DownPress) MenuOption++;
	if (Input.UpPress)   MenuOption--;
	
	// Loop through options
	var LinesCount;
	switch MenuState
	{
		case 0: LinesCount = 3  break;
		case 1: LinesCount = 2  break;
		case 2: LinesCount = 4  break;
		case 3: LinesCount = 4  break;
		case 4: LinesCount = 6  break;
		case 5: LinesCount = 10 break;
	}
	MenuOption = wrap_zero(MenuOption, LinesCount);
		
	// Key A
	if Input.APress or Input.StartPress
	{
		switch MenuState
		{
			// Main menu behaviour
			case 0:
			{
				switch MenuOption
				{	
					case 0: MenuGoto(1, 0); break; // Go to stage select screen
					case 1: MenuGoto(2, 0); break; // Go to options screen
					case 2: game_end();     break; // Exit the game
				}
			}
			break;
		
			// Stage select behaviour
			case 1:
			{
				switch MenuOption
				{
					case 0:	room_goto(MBZ); break; // Load MBZ
					case 1: MenuGoto(0, 0); break; // Return to main menu
				}
			}
			break;
		
			// Options behaviour
			case 2:
			{
				switch MenuOption
				{	
					case 0: MenuGoto(3, 0); break; // Go to framework options
					case 1: MenuGoto(4, 0); break; // Go to video and audio options
					case 2: MenuGoto(5, 0); break; // Go to input options
					case 3: MenuGoto(0, 1); break; // Return to main menu
				}
			}
			break;
			
			// Framework menu behaviour
			case 3: 
			{
				switch MenuOption
				{
					case 0: Game.SpindashEnabled = !Game.SpindashEnabled; break; // Spindash
					case 1: Game.DropdashEnabled = !Game.DropdashEnabled; break; // Dropdash
					case 2: Game.PeeloutEnabled  = !Game.PeeloutEnabled;  break; // Peelout
					case 3: MenuGoto(2, 0)								  break; // Go back
				}
			}
			break;
			
			// Audio/video menu behaviour
			case 4:
			{
				switch MenuOption
				{	
					// Aspect ratio
					case 0: 
					{	
						Game.ResolutionWidth = Game.ResolutionWidth == 398 ? 320 : 398;
						
						camera_set_view_size(view_camera[0], Game.ResolutionWidth, Game.ResolutionHeight);
						surface_resize(application_surface,  Game.ResolutionWidth, Game.ResolutionHeight);
						window_set_size(Game.ResolutionWidth * Game.WindowSize, Game.ResolutionHeight * Game.WindowSize);
					}
					break;
					
					// Window size
					case 1: 
					{	
						if Game.WindowSize < 4
						{
							Game.WindowSize++;
						}
						else
						{
							Game.WindowSize = 1;
						}
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
						if Game.MusicVolume < 1
						{
							Game.MusicVolume += 0.1;
						}
						else
						{
							Game.MusicVolume = 0;
						}
					}
					break;
					
					// Sound volume
					case 4: 
					{	
						if Game.SoundVolume < 1
						{
							Game.SoundVolume += 0.1;
						}
						else
						{
							Game.SoundVolume = 0;
						}
					}
					break;
					
					case 5: MenuGoto(2, 1); break; // Go back
				}
			}
			break;
			
			// Input menu behaviour
			case 5: if (MenuOption == 9) MenuGoto(2, 2); break; // Go back
		}
	}
	
	if MenuState == 5 and MenuOption < 9
	{
		if ChngCntrl and keyboard_check_pressed(vk_anykey) 
		{
			Game.Control[MenuOption] = keyboard_key;
			ChngCntrl = false;
			keyboard_clear(keyboard_key);
			Input.IgnoreInput = false;
		}
		else if (Input.APress or Input.StartPress) and !ChngCntrl
		{
			ChngCntrl = true;
			Input.IgnoreInput = true;
		}
	}
	
	if (Input.RightPress or Input.LeftPress)
	{
		if MenuState == 4 
		{
			switch MenuOption
			{
				
				// Aspect ratio
				case 0: 
				{	
					Game.ResolutionWidth = Game.ResolutionWidth == 398 ? 320 : 398;
						
					camera_set_view_size(view_camera[0], Game.ResolutionWidth, Game.ResolutionHeight);
					surface_resize(application_surface,  Game.ResolutionWidth, Game.ResolutionHeight);
					window_set_size(Game.ResolutionWidth * Game.WindowSize, Game.ResolutionHeight * Game.WindowSize);
				}
				break;
				
				// Window size
				case 1:
				{	
					if (Input.RightPress) Game.WindowSize++ else Game.WindowSize--;
					Game.WindowSize = wrap(Game.WindowSize, 1, 5);
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
					if (Input.RightPress) Game.MusicVolume += 0.1 else Game.MusicVolume -= 0.1;
					Game.MusicVolume = wrap_zero(round(Game.MusicVolume * 10), 11) / 10;
				}
				break;
					
				// Sound volume
				case 4: 
				{	
					if (Input.RightPress) Game.SoundVolume += 0.1 else Game.SoundVolume -= 0.1;
					Game.SoundVolume = wrap_zero(round(Game.SoundVolume * 10), 11) / 10;
				}
				break;
			}
		} 
		else if MenuState == 3 
		{
			switch MenuOption
			{
				case 0: Game.SpindashEnabled = !Game.SpindashEnabled; break; // Spindash
				case 1: Game.DropdashEnabled = !Game.DropdashEnabled; break; // Dropdash
				case 2: Game.PeeloutEnabled  = !Game.PeeloutEnabled;  break; // Peelout
			}
		}
	}
	
	// Set Sonic
	var X = Game.ResolutionWidth / 2;
	var Y = Game.ResolutionHeight / 2;
	
	objLoadingIcon.x = X - 110;
	objLoadingIcon.y = Y - 21 + MenuOption * 15;
	if (MenuState = 5) objLoadingIcon.y -= 30;