function MenuDisplay()
{
	// Disable fade
	Game.FadeEnabled = false;
	
	// Get screen centre
	var X = Game.ResolutionWidth  / 2;
	var Y = Game.ResolutionHeight / 2;
	
	// Set font
	draw_set_font(Game.Font[FontMenu]);
	
	// Set font to use in the room
	draw_set_halign(fa_center);
	
	// Display framework title
	string_display(X, Y - 75, "ORBINAUT FRAMEWORK", 1);
	string_display(X, Y - 65, "START MENU", 1);	
				
	switch MenuState
	{
		// Display menu 0 (main)
		case Main:
		{	
			draw_set_halign(fa_center);
			string_display(X, Y - 15, "STAGE SELECT",1);
			string_display(X, Y,	  "", 1);
			string_display(X, Y + 15, "OPTIONS", 1);
			string_display(X, Y + 30, "CLOSE GAME", 1);
		}
		break;
		
		// Display menu 1 (Start Game)
		case DataSelect:
		{	
			draw_set_halign(fa_center);	
			string_display(X, Y - 15, "NO SAVE", 1);
			for (var i = 0; i < 4; i++)
			{	
				if Saveslot[i] != 0
				{	
					// Get zones
					switch Saveslot[i][SavedZone]
					{
						case 0: var DisplayZone = "GVZ";  break;
					}
					
					// Get character
					switch Saveslot[i][SavedChar]
					{
						case CharSonic:    var DisplayChar = "SONIC";    break;
						case CharTails:    var DisplayChar = "TAILS";    break;
						case CharKnuckles: var DisplayChar = "KNUCKLES"; break;
					}
					
					// Display data info
					string_display(X, Y + i * 15, "SLOT " + string(i) + ": " + DisplayChar + " " + DisplayZone, 1);
				}
				else
				{
					// Display "new game" slot
					string_display(X, Y + i * 15, "SLOT " + string(i) + ": NEW GAME", 1);	
				}
			}
			string_display(X, Y + 60, "DELETE SAVE", 1);
			string_display(X, Y + 75, "BACK", 1);	
		}
		break;
		
		// Display character select menu
		case CharacterSelect:
		{
			draw_set_halign(fa_center);
			string_display(X, Y - 15, "SONIC", 1);
			string_display(X, Y,	  "TAILS", 1);
			string_display(X, Y + 15, "KNUCKLES", 1);
			string_display(X, Y + 30, "BACK", 1);		
		}
		break;
		
		// Display menu 2 (options)
		case Options:
		{	
			draw_set_halign(fa_center);	
			string_display(X, Y - 15, "GAMEPLAY", 1);
			string_display(X, Y,	  "VIDEO AND AUDIO", 1);
			string_display(X, Y + 15, "INPUT", 1);
			string_display(X, Y + 30, "BACK", 1);
		}
		break;
			
		// Display menu 3 (framework options)
		case FrameworkConfig:
		{
			draw_set_halign(fa_left);
			if MenuOption <= 6
			{
				string_display(X - 80, Y - 15, "SPINDASH",		   1);
				string_display(X - 80, Y,	   "DROPDASH",		   1);
				string_display(X - 80, Y + 15, "SUPER PEEL OUT",   1);
				string_display(X - 80, Y + 30, "GROUND SPEEDCAP",  1);
				string_display(X - 80, Y + 45, "AIR SPEEDCAP",     1);
				string_display(X - 80, Y + 60, "ROLLJUMP CONTROL", 1);
				string_display(X - 80, Y + 75, "UNROLL MOVE",	   1);
				string_display(X + 65, Y - 15, Game.SpindashEnabled ? "ON" : "OFF", 1);
				string_display(X + 65, Y,	   Game.DropdashEnabled ? "ON" : "OFF", 1);
				string_display(X + 65, Y + 15, Game.PeeloutEnabled  ? "ON" : "OFF", 1);
				string_display(X + 65, Y + 30, Game.GroundSpeedcap  ? "ON" : "OFF", 1);
				string_display(X + 65, Y + 45, Game.AirSpeedcap     ? "ON" : "OFF", 1);
				string_display(X + 65, Y + 60, Game.RolljumpControl ? "ON" : "OFF", 1);
				string_display(X + 65, Y + 75, Game.AllowUnroll     ? "ON" : "OFF", 1);
			}
			else
			{
				string_display(X - 80, Y - 15, "EXTENDED CAMERA",  1);
				string_display(X - 80, Y,      "OG ROLL LIMIT",    1);
				string_display(X - 80, Y + 15, "FLYING CANCEL",    1);
				string_display(X - 80, Y + 30, "BACK",			   1);
				string_display(X + 65, Y - 15, Game.ExtendedCamera    ? "ON" : "OFF", 1);
				string_display(X + 65, Y,	   Game.OriginalRollLimit ? "ON" : "OFF", 1);
				string_display(X + 65, Y + 15, Game.FlyingCancel      ? "ON" : "OFF", 1);
			}	
		}
		break;

		// Display menu 4 (video and audio options)
		case AudioVideoConfig:
		{
			draw_set_halign(fa_left);
			string_display(X - 80, Y - 15, "ASPECT RATIO", 1);
			string_display(X - 80, Y,      "WINDOW SIZE", 1);
			string_display(X - 80, Y + 15, "FULLSCREEN", 1);
			string_display(X - 80, Y + 30, "MUSIC VOLUME", 1);
			string_display(X - 80, Y + 45, "SOUND VOLUME", 1);
			string_display(X - 80, Y + 60, "BACK", 1);
			string_display(X + 50, Y - 15, Game.ResolutionWidth == 398 ? "16:9" : "21:9", 1);
			string_display(X + 50, Y,	   string(Game.WindowSize) + "X", 1);
			string_display(X + 50, Y + 15, Game.WindowFullscreen ? "ON" : "OFF", 1);
			string_display(X + 50, Y + 30, string(round(Game.MusicVolume * 100)), 1);
			string_display(X + 50, Y + 45, string(round(Game.SoundVolume * 100)), 1);
		}
		break;
		
		// Display menu 5 (input options)
		case InputConfig:
		{
			draw_set_halign(fa_right);
			string_display(X - 16, Y - 45, "UP:", 1);
			string_display(X - 16, Y - 30, "DOWN:", 1);
			string_display(X - 16, Y - 15, "LEFT:", 1);
			string_display(X - 16, Y,	   "RIGHT:", 1);
			string_display(X - 16, Y + 15, "A:", 1);
			string_display(X - 16, Y + 30, "B:", 1);
			string_display(X - 16, Y + 45, "C:", 1);
			string_display(X - 16, Y + 60, "MODE:", 1);
			string_display(X - 16, Y + 75, "START:", 1);
			string_display(X + 16, Y + 90, "BACK", 1);
			draw_set_halign(fa_left);
			for (var i = 0; i < 9; i++) 
			{
				string_display(X, Y - 45 + 15 * i, i == MenuOption and ControlEditMode ? ": :" : string(Game.KeyboardControl[i]) + ":" + menu_input_get_keyname(Game.KeyboardControl[i]), 1);
			}			
		}
		break;
		
		// Display menu 6 (stage select)
		case StageSelect:
		{
			draw_set_halign(fa_left);
			string_display(X - 80, Y - 15, "GEMSTONE VALLEY", 1);
			string_display(X - 80, Y, "BACK", 1);			
		}
		break;
	}
}