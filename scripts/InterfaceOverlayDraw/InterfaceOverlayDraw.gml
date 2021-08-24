function InterfaceOverlayDraw() 
{	
	// Exit if overlay is disabled
	if !Enabled
	{
		exit;
	}
	
	// Set text align
	draw_set_halign(fa_right);
	
	// Get position for overlay
	var ScreenX = OffsetX;
	var ScreenY = OffsetY;
	
	// Handle stage timer
	var StageTime = Stage.Time;
	if  StageTime < 35999
	{
		var Minutes		 = StageTime div 3600;
		var Seconds		 = (StageTime - Minutes * 3600) div 60;
		var MilliSeconds = floor(StageTime mod 60 / 3 * 5);
	} 
	else 
	{
		var Minutes		 = 9;
		var Seconds		 = 59;
		var MilliSeconds = 99;
	}
		
	// Display SCORE, TIME and RINGS graphics
	draw_sprite(gui_hud_score, 0,											 ScreenX + 16, ScreenY + 9);
	draw_sprite(gui_hud_time,  StageTime > 32400 ? animate_sprite(2, 8) : 0, ScreenX + 16, ScreenY + 25);
	draw_sprite(gui_hud_rings, Player.Rings == 0 ? animate_sprite(2, 8) : 0, ScreenX + 16, ScreenY + 41);
	
	draw_set_font(Game.Font[font_counter]);
	draw_text(ScreenX + 112, ScreenY + 9,  Player.Score);

	var TimeString = string(Minutes) + (Game.CDStageTimer ? "'" : ":") + (Seconds > 9 ? "" : "0") + string(Seconds);
	if Game.CDStageTimer
	{
		TimeString += ";" + (MilliSeconds > 9 ? "" : "0") + string(MilliSeconds);
	}
	draw_text(ScreenX + Game.CDStageTimer ? 112 : 88, ScreenY + 25, TimeString);
	
	draw_text(ScreenX + 88,  ScreenY + 41, Player.Rings);
		
	// Display LIVES counter
	draw_sprite(gui_hud_lives, Game.Character, ScreenX + 16, ScreenY + Game.Height - 24);
	
	draw_set_font(Game.Font[font_counter_small]);
	draw_text(ScreenX + 65, ScreenY + Game.Height - 15, Player.Lives);
}