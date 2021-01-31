/// @description Options
// You can write your code in this editor
	
	// Get centre
	var X = Game.ResolutionWidth / 2;
	var Y = Game.ResolutionHeight / 2;
	
	// Set font to use in the room
	string_set_font(Game.Font[0], "centre");
	
	// Display framework title
	string_display(X, Y - 75, "ORBINAUT FRAMEWORK", 1);
	string_display(X, Y - 65, "START MENU", 1);	
				
	switch MenuState
	{
		// Display menu 0 (main)
		case 0:
		{		
			string_set_font(Game.Font[0], "centre");
			
			string_display(X, Y - 15, "STAGE SELECT", 1);
			string_display(X, Y, "OPTIONS", 1);
			string_display(X, Y + 15, "CLOSE GAME", 1);
		}
		break;
		
		// Display menu 1 (stage select)
		case 1:
		{
		}
		break;
		
		// Display menu 2 (options)
		case 2:
		{
			string_set_font(Game.Font[0], "left");
		
			string_display(X - 80, Y - 15, "COLLISION METHOD:", 1);
			string_display(X - 80, Y, "BACK", 1);
		}
	}
	
	
	