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
		var Minutes	     = StageTime div 3600;
		var Seconds	     = (StageTime - Minutes * 3600) div 60;
		var MilliSeconds = floor(StageTime mod 60 / 3 * 5);
	} 
	else 
	{
		var Minutes	= 9;
		var Seconds = 59;
		var MilliSeconds = 99;
	}
		
	// Draw SCORE, TIME and RINGS graphics
	if StageTime > 32400
	{
		draw_animated_sprite(gui_hud_time, 8, true, ScreenX + 31, ScreenY + 30);
	}
	else
	{
		draw_sprite(gui_hud_time, 0, ScreenX + 31, ScreenY + 30);
	}
	if !Player.Rings
	{
		draw_animated_sprite(gui_hud_rings, 8, true, ScreenX + 35, ScreenY + 46);
	}
	else
	{
		draw_sprite(gui_hud_rings, 0, ScreenX + 35, ScreenY + 46);
	}
	draw_sprite(gui_hud_score, 0, ScreenX + 35, ScreenY + 14);
	
	// Draw SCORE counter
	draw_set_font(game_font(font_counter));
	draw_text(ScreenX + 115, ScreenY + 14,  Player.Score);
	
	// Draw TIME counter
	var TimeString = string(Minutes) + (Game.CDStageTimer ? "'" : ":") + (Seconds > 9 ? "" : "0") + string(Seconds);
	if Game.CDStageTimer
	{
		TimeString += ";" + (MilliSeconds > 9 ? "" : "0") + string(MilliSeconds);
	}
	draw_text(ScreenX + Game.CDStageTimer ? 114 : 91, ScreenY + 30, TimeString);
	
	// Draw RINGS counter
	draw_text(ScreenX + 91, ScreenY + 46, Player.Rings);
		
	// Draw LIVES counter
	draw_sprite(gui_hud_lives, Game.Character, ScreenX + 40, ScreenY + Game.Height - 16);
	
	draw_set_font(game_font(font_counter_small));
	draw_text(ScreenX + 68, ScreenY + Game.Height - 12, Player.Lives);
}