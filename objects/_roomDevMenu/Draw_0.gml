/// @description Options
// You can write your code in this editor
	
	var Timer  = TextTimer div 3;
	var Print  = TextPrint div 2;
	var MTimer = MainTimer div 3;
	var MPrint = MainPrint div 2;
	
	// Get centre
	var X = Game.ResolutionWidth  / 2;
	var Y = Game.ResolutionHeight / 2;
	
	// Set font to use in the room
	draw_set_halign(fa_center);
	
	// Display framework title
	string_display(X, Y - 75, string_distort("ORBINAUT FRAMEWORK", MPrint, MTimer), 1);
	string_display(X, Y - 65, string_distort("START MENU", MPrint, MTimer), 1);	
				
	switch MenuState
	{
		// Display menu 0 (main)
		case Main:
		{	
			draw_set_halign(fa_center);
			
			string_display(X, Y - 15, string_distort("DATA SELECT", Print, Timer), 1);
			string_display(X, Y,	  string_distort("OPTIONS", Print, Timer), 1);
			string_display(X, Y + 15, string_distort("CLOSE GAME", Print, Timer), 1);
		}
		break;
		
		// Display menu 1 (data select)
		case DataSelect:
		{	
			draw_set_halign(fa_center);
			string_display(X, Y - 15, string_distort("NO SAVE: GO TO STAGE SELECT", Print, Timer), 1);
			string_display(X, Y,	  string_distort(menu_string_savedata(0), Print, Timer), 1);
			string_display(X, Y + 15, string_distort(menu_string_savedata(1), Print, Timer), 1);
			string_display(X, Y + 30, string_distort(menu_string_savedata(2), Print, Timer), 1);
			string_display(X, Y + 45, string_distort(menu_string_savedata(3), Print, Timer), 1);
			string_display(X, Y + 60, string_distort("DELETE SAVE", Print, Timer), 1);
			string_display(X, Y + 75, string_distort("BACK", Print, Timer), 1);
			
		}
		break;
		
		// Display menu 2 (options)
		case Options:
		{	
			draw_set_halign(fa_center);
			
			string_display(X, Y - 15, string_distort("GAMEPLAY", Print, Timer), 1);
			string_display(X, Y,	  string_distort("VIDEO AND AUDIO", Print, Timer), 1);
			string_display(X, Y + 15, string_distort("INPUT", Print, Timer), 1);
			string_display(X, Y + 30, string_distort("BACK", Print, Timer), 1);
		}
		break;
		
		// Display menu 3 (framework options)
		case FrameworkConfig:
		{
			draw_set_halign(fa_left);
			
			string_display(X - 80, Y - 15, string_distort("SPINDASH", Print, Timer), 1);
			string_display(X - 80, Y,	   string_distort("DROPDASH", Print, Timer), 1);
			string_display(X - 80, Y + 15, string_distort("SUPER PEEL OUT", Print, Timer), 1);
			string_display(X - 80, Y + 30, string_distort("BACK", Print, Timer), 1);
			
			string_display(X + 65, Y - 15, string_distort(Game.SpindashEnabled ? "ON" : "OFF", Print, Timer), 1);
			string_display(X + 65, Y,	   string_distort(Game.DropdashEnabled ? "ON" : "OFF", Print, Timer), 1);
			string_display(X + 65, Y + 15, string_distort(Game.PeeloutEnabled  ? "ON" : "OFF", Print, Timer), 1);
		}
		break;
		
		// Display menu 4 (video and audio options)
		case AudioVideoConfig:
		{
			draw_set_halign(fa_left);
			
			string_display(X - 80, Y - 15, string_distort("ASPECT RATIO", Print, Timer), 1);
			string_display(X - 80, Y,      string_distort("WINDOW SIZE",  Print, Timer), 1);
			string_display(X - 80, Y + 15, string_distort("FULLSCREEN",   Print, Timer), 1);
			string_display(X - 80, Y + 30, string_distort("MUSIC VOLUME", Print, Timer), 1);
			string_display(X - 80, Y + 45, string_distort("SOUND VOLUME", Print, Timer), 1);
			string_display(X - 80, Y + 60, string_distort("BACK",		  Print, Timer), 1);
			
			string_display(X + 50, Y - 15, string_distort(Game.ResolutionWidth == 398 ? "16:9" : "4:3", Print, Timer), 1);
			string_display(X + 50, Y,	   string_distort(string(Game.WindowSize) + "X",		 Print, Timer), 1);
			string_display(X + 50, Y + 15, string_distort(Game.WindowFullscreen ? "ON" : "OFF",  Print, Timer), 1);
			string_display(X + 50, Y + 30, string_distort(string(round(Game.MusicVolume * 100)), Print, Timer), 1);
			string_display(X + 50, Y + 45, string_distort(string(round(Game.SoundVolume * 100)), Print, Timer), 1);
		}
		break;
		
		// Display menu 5 (input options)
		case InputConfig:
		{
			draw_set_halign(fa_right);
			
			string_display(X - 16, Y - 45, string_distort("UP:",      Print, Timer), 1);
			string_display(X - 16, Y - 30, string_distort("DOWN:",    Print, Timer), 1);
			string_display(X - 16, Y - 15, string_distort("LEFT:",    Print, Timer), 1);
			string_display(X - 16, Y,	   string_distort("RIGHT:",   Print, Timer), 1);
			string_display(X - 16, Y + 15, string_distort("A:",		 Print,  Timer), 1);
			string_display(X - 16, Y + 30, string_distort("B:",		 Print,  Timer), 1);
			string_display(X - 16, Y + 45, string_distort("C:",		 Print,  Timer), 1);
			string_display(X - 16, Y + 60, string_distort("MODE:",    Print, Timer), 1);
			string_display(X - 16, Y + 75, string_distort("START:",   Print, Timer), 1);
			string_display(X + 16, Y + 90, string_distort("BACK",	 Print,  Timer), 1);
			
			draw_set_halign(fa_left);
			for (var i = 0; i < 9; i++) {
				string_display(X, Y - 45 + 15 * i, string_distort(i == MenuOption and ChngCntrl ? ": :" : string(Game.Control[i]) + ":" + InputKeyname(Game.Control[i]), Print, Timer), 1);
			}
		}
		break;
		
		// Display menu 6 (stage select)
		case StageSelect:
		{
			draw_set_halign(fa_left);
			
			string_display(X - 80, Y - 15, string_distort("MOONLIGHT BASE ZONE", Print, Timer), 1);
			string_display(X - 80, Y,	   string_distort("HORIZON HEIGHTS ZONE", Print, Timer), 1);
			string_display(X - 80, Y + 15, string_distort("BACK", Print, Timer), 1);
		}
		
		break;
	}