/// @description Options
// You can write your code in this editor
	
	var Timer = TextTimer div 3;
	var Print = TextPrint div 2;
	var MTimer = MainTimer div 3;
	var MPrint = MainPrint div 2;
	
	// Get centre
	var X = Game.ResolutionWidth / 2;
	var Y = Game.ResolutionHeight / 2;
	
	// Set font to use in the room
	draw_set_halign(fa_center);
	
	// Display framework title
	string_display(X, Y - 75, string_distort("ORBINAUT FRAMEWORK", MPrint, MTimer), 1);
	string_display(X, Y - 65, string_distort("START MENU", MPrint, MTimer), 1);	
				
	switch MenuState
	{
		// Display menu 0 (main)
		case 0:
		{	
			draw_set_halign(fa_center);
			
			string_display(X, Y - 15, string_distort("STAGE SELECT", Print, Timer), 1);
			string_display(X, Y, string_distort("OPTIONS", Print, Timer), 1);
			string_display(X, Y + 15, string_distort("CLOSE GAME", Print, Timer), 1);
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
			draw_set_halign(fa_left);
			
			string_display(X - 80, Y - 15, string_distort("COLLISION METHOD:", Print, Timer), 1);
			string_display(X - 80, Y, string_distort("BACK", Print, Timer), 1);
		}
		break;
		// Display menu 3 (control)
		case 3:
		{
			draw_set_halign(fa_left);
			
			string_display(X - 80, Y - 15, string_distort("COLLISION METHOD:", Print, Timer), 1);
			string_display(X - 80, Y, string_distort("BACK", Print, Timer), 1);
		}
		break;
	}