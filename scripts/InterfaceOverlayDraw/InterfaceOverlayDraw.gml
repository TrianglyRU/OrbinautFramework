function InterfaceOverlayDraw() 
{	
	if !Enabled
	{
		return;
	}
	
	var X = OffsetX + global.ScreenBuffer;
	var Y = OffsetY;
	
	draw_set_font(Font.FontDigits1);
	
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
	draw_sprite(gui_hud_score, 0, X + 36, Y + 14);
	
	draw_set_halign(fa_right);	
	draw_text(X + 116, Y + 14, Player.Score);
	
	// Draw TIME
	if Stage.Time > 32400
	{
		draw_animated_sprite(gui_hud_time, 8, true, X + 32, Y + 30);
	}
	else
	{
		draw_sprite(gui_hud_time, 0, X + 32, Y + 30);
	}
	if !global.CDStageTimer
	{
		var TimeString = string(Min) + ":" + (Sec > 9 ? "" : "0") + string(Sec);
	}
	else
	{
		var TimeString = string(Min) + "'" + (Sec > 9 ? "" : "0") + string(Sec) + ";" + (Msc > 9 ? "" : "0") + string(Msc);
	}
	draw_set_halign(fa_left);
	
	draw_text(X + 60, Y + 30, TimeString);
	
	// Draw RINGS
	if !Player.Rings
	{
		draw_animated_sprite(gui_hud_rings, 8, true, X + 36, Y + 46);
	}
	else
	{
		draw_sprite(gui_hud_rings, 0, X + 36, Y + 46);
	}	
	draw_set_halign(fa_right);
	
	draw_text(X + 92, Y + 46, Player.Rings);

	// Draw LIVES
	draw_set_font(Font.FontDigits2);
	draw_text(X + 68, Y + global.Height - 12, Player.Lives);
	
	if global.Character == CharSonic
	{
		var SpriteFrame = Player.SuperState ? 3 : global.Character;
	}
	else
	{
		var SpriteFrame = global.Character;
	}
	draw_sprite(gui_hud_lives, SpriteFrame, X + 40, Y + global.Height - 16);
}