/// @description Navigation
// You can write your code in this editor
	
	// Disable fade
	Game.FadeEnabled = false;
	
	if Saving
	{
		// Navigate between characters
		if (Input.RightPress)  CharID++;
		if (Input.LeftPress)   CharID--;
		
		// Loop through characters
		CharID = loop_value(CharID, 0, 3);
	}
	else
	{
		// Navigate between options
		if (Input.DownPress) MenuOption++;
		if (Input.UpPress)   MenuOption--;
		
		// Loop through options
		var LinesCount;
		switch MenuState
		{
			case Main:			   LinesCount = 4  break;
			case DataSelect:	   LinesCount = 7  break;
			case Options:		   LinesCount = 4  break;
			case FrameworkConfig:  LinesCount = 4  break;
			case AudioVideoConfig: LinesCount = 6  break;
			case InputConfig:	   LinesCount = 10 break;
			case StageSelect:	   LinesCount = 4  break;
		}
		MenuOption = loop_value(MenuOption, 0, LinesCount);
	}
	
	// React to key A and key start
	if Input.APress or Input.StartPress
	{
		switch MenuState
		{
			case Main:
			{
				switch MenuOption
				{	
					case 0: menu_goto(StageSelect, 0); break; // Go to stage select screen
					case 1: menu_goto(DataSelect, 0);  break; // Go to data select screen
					case 2: menu_goto(Options, 0);     break; // Go to options screen
					case 3: game_end();				   break; // Exit the game
				}
			}
			break;
			case DataSelect:
			{
				// Go to MBZ if no save slot selected
				if MenuOption = 0
				{
					room_goto(MBZ);
				}
				else if MenuOption < 5
				{	
					// Define the saveslot we selected
					Game.SaveslotUsed = MenuOption - 1;
					
					// Check saved act
					switch DataSlot[MenuOption - 1][1]
					{	
						// If saved act is act 1
						case 0:
						{
							switch DataSlot[MenuOption - 1][0]
							{
								case 0: room_goto(MBZ); break;
								case 1: room_goto(HHZ); break;
							}
							break;
						}
						
						// If saved act is act 2
						case 1:
						{
							switch DataSlot[MenuOption - 1][0]
							{
								case 0: room_goto(MBZ2); break;
								case 1: room_goto(HHZ); break;
							}
							break;
						}
					}
				}
				else
				{
					switch MenuOption
					{
						case 5: Delete = true;  break;
						case 6: Delete = false; menu_goto(Main, 0); break;
					}
				}
				/*case 0: Delete = false; room_goto(MBZ);			   break; // Go to MBZ on a "no save" slot
				case 5:	if (Game.SaveSlot != [0,0,0,0]) Delete = true; break; // Delete save
				case 6: Delete = false; menu_goto(Main, 0);			   break; // Return to main menu
				default:
				{
					var slot = MenuOption - 1;
					if Delete 
					{
						if Game.SaveSlot[slot] != 0
						{
							Delete = false;
							Game.SaveSlot[slot] = 0;
							file_delete("saveslot" + string(slot) + ".txt");
						}
					}
					else if Game.SaveSlot[slot] = 0
					{
						if Saving
						{
							Saving = false;
							Game.SaveSlot[slot][0] = CharID;
							Game.SaveSlot[slot][1] = MBZ;
							Game.SaveSlot[slot][2] = 3;
							Game.SaveSlot[slot][3] = 0;
							data_save(slot);
						}
						else
						{
							Saving = true;
						}
						
					}
					else
					{
						room_goto(Game.SaveSlot[slot][1]);
					}
				}*/
			}
			break;
			case Options:
			{
				switch MenuOption
				{	
					case 0: menu_goto(FrameworkConfig, 0);			 break; // Go to framework options
					case 1: menu_goto(AudioVideoConfig, 0);			 break; // Go to video and audio options
					case 2: menu_goto(InputConfig, 0);				 break; // Go to input options
					case 3: menu_goto(Main, 1); gamesettings_save(); break; // Return to main menu
				}
			}
			break;
			case FrameworkConfig: 
			{	
				// Go back
				if MenuOption = 3
				{
					menu_goto(Options, 0)
				}
			}
			break;
			case AudioVideoConfig:
			{
				// Go back
				if MenuOption = 5
				{
					menu_goto(Options, 1);
				}
			}
			break;
			case InputConfig: 
			{
				// Go back
				if MenuOption = 9 
				{
					menu_goto(Options, 2);
				}
			}
			break;
			case StageSelect:
			{
				switch MenuOption
				{
					case 0:	room_goto(MBZ);     break; // Load MBZ1
					case 1:	room_goto(MBZ2);    break; // Load MBZ2
					case 2:	room_goto(HHZ);     break; // Load HHZ
					case 3: menu_goto(Main, 0); break; // Return to main menu
				}
			}
			break;
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
					Game.ResolutionWidth = Game.ResolutionWidth == 398 ? 530 : 398;
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
			Game.Control[MenuOption] = string(keyboard_key);
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
	objLoadingIcon.x = Game.ResolutionWidth / 2 - 110;
	objLoadingIcon.y = Game.ResolutionHeight / 2 - 21 + MenuOption * 15;
	if (MenuState = InputConfig) objLoadingIcon.y -= 30;
	if (MenuState = DataSelect)  objLoadingIcon.x -= 30;