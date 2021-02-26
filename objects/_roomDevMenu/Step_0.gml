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
		case 1: LinesCount = 3  break;
		case 2: LinesCount = 4  break;
		case 3: LinesCount = 4  break;
		case 4: LinesCount = 6  break;
		case 5: LinesCount = 10 break;
	}
	MenuOption = loop_value(MenuOption, 0, LinesCount);
		
	// React to key A and key start
	if Input.APress or Input.StartPress
	{
		switch MenuState
		{
			case Main:
			{
				switch MenuOption
				{	
					case 0: MenuGoto(StageSelect, 0); break; // Go to stage select screen
					case 1: MenuGoto(Options, 0);     break; // Go to options screen
					case 2: game_end();				  break; // Exit the game
				}
			}
			break;
			case StageSelect:
			{
				switch MenuOption
				{
					case 0:	room_goto(MBZ);    break; // Load MBZ
					case 1:	room_goto(HHZ);    break; // Load HHZ
					case 2: MenuGoto(Main, 0); break; // Return to main menu
				}
			}
			break;
			case Options:
			{
				switch MenuOption
				{	
					case 0: MenuGoto(FrameworkConfig, 0);  break; // Go to framework options
					case 1: MenuGoto(AudioVideoConfig, 0); break; // Go to video and audio options
					case 2: MenuGoto(InputConfig, 0);	   break; // Go to input options
					case 3: MenuGoto(Main, 1);             break; // Return to main menu
				}
			}
			break;
			case FrameworkConfig: 
			{	
				// Go back
				if MenuOption = 3
				{
					MenuGoto(Options, 0)
				}
			}
			break;
			case AudioVideoConfig:
			{
				// Go back
				if MenuOption = 5
				{
					MenuGoto(Options, 1);
				}
			}
			break;
			case InputConfig: 
			{
				// Go back
				if MenuOption = 9 
				{
					MenuGoto(Options, 2);
				}
			}
		}
	}
	
	// React to key left and key right
	if (Input.RightPress or Input.LeftPress)
	{
		if MenuState = AudioVideoConfig
		{
			switch MenuOption
			{				
				// Aspect ratio
				case 0: 
				{	
					Game.ResolutionWidth = Game.ResolutionWidth == 398 ? 320 : 398;
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
				case 0: Game.SpindashEnabled = !Game.SpindashEnabled; break; // Spindash
				case 1: Game.DropdashEnabled = !Game.DropdashEnabled; break; // Dropdash
				case 2: Game.PeeloutEnabled  = !Game.PeeloutEnabled;  break; // Peelout
			}
		}
	}
	
	// Keyboard contol config
	if MenuState = InputConfig and MenuOption < 9
	{	
		// Exit button assign state
		if ChngCntrl and keyboard_check_pressed(vk_anykey) 
		{
			Game.Control[MenuOption] = keyboard_key;
			ChngCntrl = false;
			keyboard_clear(keyboard_key);
			Input.IgnoreInput = false;
		}
		
		// Enter button assign state
		else if (Input.APress or Input.StartPress) and !ChngCntrl
		{
			ChngCntrl		  = true;
			Input.IgnoreInput = true;
		}
	}
	
	// Set Sonic
	var X = Game.ResolutionWidth / 2;
	var Y = Game.ResolutionHeight / 2;
	objLoadingIcon.x = X - 110;
	objLoadingIcon.y = Y - 21 + MenuOption * 15;
	if (MenuState = InputConfig) objLoadingIcon.y -= 30;