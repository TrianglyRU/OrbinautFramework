function MenuOptionSelect()
{
	// Navigate between options
	if (Input.DownPress) MenuOption++;
	if (Input.UpPress)   MenuOption--;
		
	// Loop through options. This is important when you add new lines to the menus. (If there are 4 lines then value is 4, not 3)
	var LinesCount;
	switch MenuState
	{
		case Main:			   LinesCount = 4;  break;
		case DataSelect:	   LinesCount = 7;  break;
		case Options:		   LinesCount = 4;  break;
		case FrameworkConfig:  LinesCount = 11; break;
		case AudioVideoConfig: LinesCount = 6;  break;
		case InputConfig:	   LinesCount = 10; break;
		case StageSelect:	   LinesCount = 2;  break;
		case CharacterSelect:  LinesCount = 4;  break;
	}
	MenuOption = loop_value(MenuOption, LinesCount);
	
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
				break;
			}
			break;
			case DataSelect:
			{
				// Ignore all savefile manipulations and go straight to character select if
				// selected "no save" slot
				if MenuOption == 0
				{
					menu_goto(CharacterSelect, 0);
					SaveNewData = false;
				}
				else if MenuOption < 5
				{	
					// Define the saveslot we selected
					Game.ActiveSave = MenuOption - 1;
					
					// Check if we're not trying to delete a save
					if !DataDeleteMode
					{
						// Check if savefile exists
						if Saveslot[Game.ActiveSave] != 0
						{	
							// Load the data
							Game.GlobalCharacter = Saveslot[Game.ActiveSave][SavedChar];
							Game.GlobalScore	 = Saveslot[Game.ActiveSave][SavedScore];
							Game.GlobalLives	 = Saveslot[Game.ActiveSave][SavedLives];
							Game.GlobalEmeralds  = Saveslot[Game.ActiveSave][SavedEmeralds];
							Game.GlobalConts     = Saveslot[Game.ActiveSave][SavedConts];
						
							// Load the Zone using its ID
							switch Saveslot[Game.ActiveSave][SavedZone]
							{	
								case 0: room_goto(GVZ); break;
							}							
						}
					
						// Else create new and go to character select
						else
						{
							menu_goto(CharacterSelect, 0);
							SaveNewData = true;
						}
					}
					
					// Else delete the savefile
					else
					{
						file_delete("saveslot" + string(Game.ActiveSave) + ".bin");
						Saveslot[Game.ActiveSave] = 0;
						DataDeleteMode = false;
					}
				}
				else
				{
					switch MenuOption
					{	
						// Enable save delete mode
						case 5: 
						{
							DataDeleteMode = true; 
						}
						break;
						case 6: 
						{
							// Go back to main menu
							DataDeleteMode = false; 
							menu_goto(Main, 0);
						}	
						break;
					}
				}
			}
			break;
			case CharacterSelect:
			{
				if MenuOption < 1
				{
					// Get our character
					Game.GlobalCharacter = MenuOption;
								
					// Save the new game if we did not select "no save" slot
					if SaveNewData
					{
						gamedata_save(Game.ActiveSave, Game.GlobalCharacter, 0, 0, 3, 0, 0);
					}
					
					// Load MBZ or selected stage (if we got here from Stage Select)
					if StageToLoad
					{
						switch StageToLoad - 1
						{			
							case 0:	room_goto(GVZ);  break; // Load GVZ
						}
					}
					else
					{
						room_goto(GVZ);
					}
				}
				else
				{	
					if StageToLoad != false
					{
						// Return to stage select
						menu_goto(StageSelect, 0);
						StageToLoad = false;
					}
					else
					{
						// Return to data select
						menu_goto(DataSelect, Game.ActiveSave + 1); 
						SaveNewData = false; 
					}
				}
			}
			break;
			case Options:
			{
				switch MenuOption
				{	
					case 0: menu_goto(FrameworkConfig, 0);	break; // Go to framework options
					case 1: menu_goto(AudioVideoConfig, 0);	break; // Go to video and audio options
					case 2: menu_goto(InputConfig, 0);	    break; // Go to input options
					case 3:										   // Return to main menu and save settings
					{
						gamesettings_save("config"); 
						menu_goto(Main, 1);	
					}
					break;
				}
			}
			break;
			case FrameworkConfig: 
			{	
				// Go back
				if MenuOption == 10
				{
					menu_goto(Options, 0)
				}
			}
			break;
			case AudioVideoConfig:
			{
				// Go back
				if MenuOption == 5
				{
					menu_goto(Options, 1);
				}
			}
			break;
			case InputConfig: 
			{
				// Go back
				if MenuOption == 9 
				{
					menu_goto(Options, 2);
				}
			}
			break;
			case StageSelect:
			{
				if MenuOption < 1
				{
					StageToLoad = MenuOption + 1
					menu_goto(CharacterSelect, 0);					
				}
				else 
				{
					menu_goto(Main, 0);
					StageToLoad = false;
				}
			}
			break;
		}
	}
}