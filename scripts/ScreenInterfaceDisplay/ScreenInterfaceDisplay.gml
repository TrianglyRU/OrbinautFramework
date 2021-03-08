function ScreenInterfaceDisplay() 
{	
	// Get position for our HUD
	var ScreenX = RenderX + InterfaceOffsetX;
	var ScreenY = RenderY + InterfaceOffsetY;
	
	// Handle timer
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
		draw_sprite(sprHUD_Score, 0,							  ScreenX + 17, ScreenY + 9);
		draw_sprite(sprHUD_Time,  TimeValue > 540 ? RedFlash : 0, ScreenX + 17, ScreenY + 25);
		draw_sprite(sprHUD_Rings, !Player.Rings   ? RedFlash : 0, ScreenX + 17, ScreenY + 41);
		draw_sprite(sprHUD_Lives, Player.CharacterID,             ScreenX + 14, ScreenY + Height - 23);
	
		// Display SCORE, TIME, RINGS counters
		string_set_font(Game.Font[FontDigits1], "right");
		
		string_display(ScreenX + 113, ScreenY + 9,  Player.Score, 1);
		string_display(ScreenX + 89,  ScreenY + 25, string(Minutes) + ":" + (Seconds > 9 ? "" : "0") + string(Seconds), 1);
		string_display(ScreenX + 89,  ScreenY + 41, Player.Rings, 1);
		
		// Use dynamic emotions for character
		if Player.CharacterID = CharSonic
		{
			if Player.Hurt
			{
				if Player.Death
				{
					draw_sprite(sprHUD_LivesSonicLose, 0, ScreenX + 16, ScreenY + Height - 23);
				
				}
				else
				{
					draw_sprite(sprHUD_LivesSonicHurt, 0, ScreenX + 16, ScreenY + Height - 23);				
				}
			}
			else
			{
				draw_sprite(sprHUD_LivesSonicNormal, 0, ScreenX + 16, ScreenY + Height - 23);
			}
		}	
		
		// Display lives counter
		string_set_font(Game.Font[FontDigits2], "right");
		string_display(ScreenX + 65, ScreenY + Height - 15, Player.Lives, 1);
	}
}