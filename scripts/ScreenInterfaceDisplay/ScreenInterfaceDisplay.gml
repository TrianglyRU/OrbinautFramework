function ScreenInterfaceDisplay() 
{	
	// Exit the code if interface is disabled
	if !InterfaceEnabled
	{
		exit;
	}
	
	// Get position for our HUD
	var ScreenX = InterfaceOffsetX;
	var ScreenY = InterfaceOffsetY;
	
	// Handle timer
	var TimeValue = Stage.Time;
	if  TimeValue < 35999
	{
		var Minutes  = TimeValue div 3600;
		var Seconds  = (TimeValue - Minutes * 3600) div 60;
		var mSeconds = floor(TimeValue mod 60 / 3 * 5);
	} 
	else 
	{
		var Minutes  = 9;
		var Seconds  = 59;
		var mSeconds = 99;
	}
	
	// Red flash timer
	var RedFlash = Stage.AnimationTime ? Stage.AnimationTime mod 16 < 8 : 0;
		
	// Draw graphics
	draw_sprite(spr_hud_score, 0,							     ScreenX + 17, ScreenY + 9);
	draw_sprite(spr_hud_time,  TimeValue > 32400 ? RedFlash : 0, ScreenX + 17, ScreenY + 25);
	draw_sprite(spr_hud_rings, !Player.Rings     ? RedFlash : 0, ScreenX + 17, ScreenY + 41);
	draw_sprite(spr_hud_lives, Player.CharacterID,               ScreenX + 14, ScreenY + Height - 23);
		
	// Display SCORE, TIME, RINGS counters
	string_set_font(Game.Font[FontDigits1], "right");
		
	string_display(ScreenX + 113, ScreenY + 9,  Player.Score, 1);
	string_display(ScreenX + 113, ScreenY + 25, string(Minutes) + "'" + (Seconds > 9 ? "" : "0") + string(Seconds) + ";" + (mSeconds > 9 ? "" : "0") + string(mSeconds), 1);
	string_display(ScreenX + 89,  ScreenY + 41, Player.Rings, 1);
		
	// Display lives counter
	string_set_font(Game.Font[FontDigits2], "right");
	string_display(ScreenX + 65, ScreenY + Height - 15, Player.Lives, 1);
	
	if Game.DevMode
	{
		string_display(Width - 57, 9,  floor(Player.PosX), 1);
		string_display(Width - 17, 9,  floor(CameraX),	   1);
		
		string_display(Width - 57, 17, floor(Player.PosY), 1);
		string_display(Width - 17, 17, floor(CameraY),	   1);
		
		string_set_font(FontDebug, "right");
		string_display(Width - 97, 9,  "X:", 1);
		string_display(Width - 97, 17, "Y:", 1);
		
		string_display(Width - 97, 24, string(Background.BackgroundValues[3][Background.BackgroundDebug]), 1);
	}
}