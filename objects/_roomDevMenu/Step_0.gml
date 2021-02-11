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
		case 0: LinesCount = 3 break;
		case 1: LinesCount = 2 break;
		case 2: LinesCount = 4 break;
		case 3: LinesCount = 4 break;
		case 4: LinesCount = 6 break;
		case 5: LinesCount = 1 break;
	}
	MenuOption = wrap_zero(MenuOption, LinesCount);
		
	// Key A
	if Input.APress
	{
		switch MenuState
		{
			// Main menu behaviour
			case 0:
			{
				switch MenuOption
				{	
					// Go to stage select screen
					case 0: 
					{
						MenuState = 1; MenuOption = 0; TextTimer = 0; TextPrint = 0;
					}
					break;
					
					// Go to options screen
					case 1: 
					{
						MenuState = 2; MenuOption = 0; TextTimer = 0; TextPrint = 0; 
					} 
					break;
					
					// Exit the game
					case 2:
					{
						game_end(); 
					}
					break;
				}
			}
			break;
		
			// Stage select behaviour
			case 1:
			{
				switch MenuOption
				{
					// Load MBZ
					case 0:
					{		
						room_goto(MBZ); 
					}
					break;
					
					// Return to main menu
					case 1: 
					{	
						MenuState = 0; MenuOption = 0; TextTimer = 0; TextPrint = 0;
					}
					break;
				}
			}
			break;
		
			// Options behaviour
			case 2:
			{
				switch MenuOption
				{	
					// Go to framework options
					case 0: 
					{
						MenuState = 3; MenuOption = 0; TextTimer = 0; TextPrint = 0;
					} 
					break;
					
					// Go to video and audio options
					case 1: 
					{	
						MenuState = 4; MenuOption = 0; TextTimer = 0; TextPrint = 0;
					}
					break;
					
					// Go to input options
					case 2: 
					{	
						MenuState = 5; MenuOption = 0; TextTimer = 0; TextPrint = 0;
					}
					break;
					
					// Return to main menu
					case 3: 
					{	
						MenuState = 0; MenuOption = 1; TextTimer = 0; TextPrint = 0;
					}
					break;
				}
			}
			break;
			
			// Framework menu behaviour
			case 3:
			{
				switch MenuOption
				{	
					// Spindash
					case 0: 
					{	
						Game.SpindashEnabled = Game.SpindashEnabled ? false : true;
					}
					break;
					
					// Dropdash
					case 1: 
					{	
						Game.DropdashEnabled = Game.DropdashEnabled ? false : true;
					}
					break;
					
					// Peelout
					case 2: 
					{	
						Game.PeeloutEnabled = Game.PeeloutEnabled ? false : true;
					}
					break;
					
					// Go back
					case 3: 
					{	
						MenuState = 2; MenuOption = 0; TextTimer = 0; TextPrint = 0;
					}
					break;
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
						Game.WindowFullscreen = Game.WindowFullscreen ? false : true;
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
					
					// Go back
					case 5: 
					{	
						MenuState = 2; MenuOption = 1; TextTimer = 0; TextPrint = 0;
					}
					break;
				}
			}
			break;
			
			// Input menu behaviour
			case 5:
			{
				switch MenuOption
				{
					// Go back
					case 0: 
					{	
						MenuState = 2; MenuOption = 2; TextTimer = 0; TextPrint = 0;
					}
					break;
				}
			}
			break;
		}
	}
	
	// Set Sonic
	var X = Game.ResolutionWidth / 2;
	var Y = Game.ResolutionHeight / 2;
	
	objLoadingIcon.x = X - 110;
	
	if MenuState = 0
	{
		switch MenuOption
		{
			case 0: objLoadingIcon.y = Y - 15 - 6; break;
			case 1: objLoadingIcon.y = Y - 6;      break;
			case 2: objLoadingIcon.y = Y + 15 - 6; break;
		}
	}
	if MenuState = 1
	{
		switch MenuOption
		{
			case 0: objLoadingIcon.y = Y - 15 - 6; break;
			case 1: objLoadingIcon.y = Y - 6;      break;
		}
	}
	if MenuState = 2 or MenuState = 3
	{
		switch MenuOption
		{
			case 0: objLoadingIcon.y = Y - 15 - 6; break;
			case 1: objLoadingIcon.y = Y - 6;	   break;
			case 2: objLoadingIcon.y = Y + 15 - 6; break;
			case 3: objLoadingIcon.y = Y + 30 - 6; break;
		}
	}
	if MenuState = 4
	{
		switch MenuOption
		{
			case 0: objLoadingIcon.y = Y - 15 - 6; break;
			case 1: objLoadingIcon.y = Y - 6;	   break;
			case 2: objLoadingIcon.y = Y + 15 - 6; break;
			case 3: objLoadingIcon.y = Y + 30 - 6; break;
			case 4: objLoadingIcon.y = Y + 45 - 6; break;
			case 5: objLoadingIcon.y = Y + 60 - 6; break;
		}
	}
	if MenuState = 5
	{
		switch MenuOption
		{
			case 0: objLoadingIcon.y = Y - 6; break;
		}
	}