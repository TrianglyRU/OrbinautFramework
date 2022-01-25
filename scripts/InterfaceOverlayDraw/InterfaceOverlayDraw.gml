function InterfaceOverlayDraw() 
{	
	if !Enabled
	{
		return;
	}
	
	// Set text align
	draw_set_halign(fa_right); draw_set_font(game_font(font_counter));
	
	// Handle stage timer
	if Stage.Time < 35999
	{
		var Min	= Stage.Time div 3600;
		var Sec	= (Stage.Time - Min * 3600) div 60;
		var Msc = floor(Stage.Time mod 60 / 3 * 5);
	} 
	else
	{
		var Min	= 9;
		var Sec = 59;
		var Msc = 99;
	}
		
	// Draw SCORE
	draw_sprite(gui_hud_score, 0, OffsetX + 36, OffsetY + 14); 
	draw_text(OffsetX + 116, OffsetY + 14, Player.Score);
	
	// Draw TIME
	if Stage.Time > 32400
	{
		draw_animated_sprite(gui_hud_time, 8, true, OffsetX + 32, OffsetY + 30);
	}
	else
	{
		draw_sprite(gui_hud_time, 0, OffsetX + 32, OffsetY + 30);
	}
	if !Game.CDStageTimer
	{
		var TimeString = string(Min) + ":" + (Sec > 9 ? "" : "0") + string(Sec);
	}
	else
	{
		var TimeString = string(Min) + "'" + (Sec > 9 ? "" : "0") + string(Sec) + ";" + (Msc > 9 ? "" : "0") + string(Msc);
	}
	draw_text(OffsetX + Game.CDStageTimer ? 116 : 92, OffsetY + 30, TimeString);
	
	// Draw RINGS
	if !Player.Rings
	{
		draw_animated_sprite(gui_hud_rings, 8, true, OffsetX + 36, OffsetY + 46);
	}
	else
	{
		draw_sprite(gui_hud_rings, 0, OffsetX + 36, OffsetY + 46);
	}
	draw_text(OffsetX + 92, OffsetY + 46, Player.Rings);

	// Draw LIVES
	draw_set_font(game_font(font_counter_small));
	
	draw_sprite(gui_hud_lives, Game.Character, OffsetX + 40, OffsetY + Game.Height - 16);
	draw_text(OffsetX + 68, OffsetY + Game.Height - 12, Player.Lives);
}