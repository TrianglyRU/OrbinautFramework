function ScreenInterfaceDisplay() 
{		
	// Show FPS
	string_set_font(Game.Font[FontDebug], "left");
	string_display(Width - 40, Height - 4, "FPS: " + string(floor(fps_real)), 0.5);
	
	// Variables list
	var TimeValue, Minutes, Seconds;

	// Time counter system
	TimeValue = Stage.Time div 60;
	if TimeValue < 599 
	{
		Minutes = TimeValue div 60;
		Seconds = TimeValue - Minutes * 60;
	} else {
		Minutes = 9;
		Seconds = 59;
	}
	
	// Exit the code if we're not allowed to draw HUD
	if !EnableHUD exit;
	
		// Red flash timer
		var RedFlash = Stage.Time mod 16 < 8;
		
		// Draw graphics
		draw_sprite(sprHUD_Score, 0, 17 + OffsetHUD[0], 9 + OffsetHUD[1]);
		draw_sprite(sprHUD_Time,  TimeValue > 540 ? RedFlash : 0, 17 + OffsetHUD[0], 9 + OffsetHUD[1] + 16);
		draw_sprite(sprHUD_Rings, !Player.Rings   ? RedFlash : 0, 17 + OffsetHUD[0], 9 + OffsetHUD[1] + 32);
		draw_sprite(sprHUD_Lives, Player.CharacterID, 14 + OffsetHUD[0], Height - 23 + OffsetHUD[1]);
	
		// Display SCORE, TIME, RINGS counters
		string_set_font(Game.Font[FontDigits1], "right");
		string_display(113 + OffsetHUD[0], 9 + OffsetHUD[1], Player.Score, 1);
		string_display(89 + OffsetHUD[0], 25 + OffsetHUD[1], string(Minutes) + ":" + (Seconds > 9 ? "" : "0") + string(Seconds), 1);
		string_display(89 + OffsetHUD[0], 41 + OffsetHUD[1], Player.Rings, 1);
		
		// Display lives counter
		string_set_font(Game.Font[FontDigits2], "right");
		string_display(65 + OffsetHUD[0], Height - 15 + OffsetHUD[1], Player.Lives, 1);
}