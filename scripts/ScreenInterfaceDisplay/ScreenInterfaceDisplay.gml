function ScreenInterfaceDisplay() 
{		
	// Show FPS
	string_set_font(Game.Font[FontDebug], "left");
	string_display(Width - 40, Height - 4, "FPS: " + string(floor(fps_real)), 0.5);
	
	// Time counter system
	var TimeValue = Stage.Time div 60;
	if  TimeValue < 599 
	{
		var Minutes = TimeValue div 60;
		var Seconds = TimeValue - Minutes * 60;
	} 
	else 
	{
		var Minutes = 9;
		var Seconds = 59;
	}
	
	// Draw HUD
	if InterfaceEnabled
	{
		// Red flash timer
		var RedFlash = Stage.Time ? Stage.Time mod 16 < 8 : 0;
		
		// Draw graphics
		draw_sprite(sprHUD_Score, 0,							  17 + InterfaceOffsetX, 9  + InterfaceOffsetY);
		draw_sprite(sprHUD_Time,  TimeValue > 540 ? RedFlash : 0, 17 + InterfaceOffsetX, 25 + InterfaceOffsetY);
		draw_sprite(sprHUD_Rings, !Player.Rings   ? RedFlash : 0, 17 + InterfaceOffsetX, 41 + InterfaceOffsetY);
		draw_sprite(sprHUD_Lives, Player.CharacterID,             14 + InterfaceOffsetX, Height - 23 + InterfaceOffsetY);
	
		// Display SCORE, TIME, RINGS counters
		string_set_font(Game.Font[FontDigits1], "right");
		
		string_display(113 + InterfaceOffsetX, 9  + InterfaceOffsetY, Player.Score, 1);
		string_display(89  + InterfaceOffsetX, 25 + InterfaceOffsetY, string(Minutes) + ":" + (Seconds > 9 ? "" : "0") + string(Seconds), 1);
		string_display(89  + InterfaceOffsetX, 41 + InterfaceOffsetY, Player.Rings, 1);
		
		// Display lives counter
		string_set_font(Game.Font[FontDigits2], "right");
		
		string_display(65 + InterfaceOffsetX, Height - 15 + InterfaceOffsetY, Player.Lives, 1);
	}
}