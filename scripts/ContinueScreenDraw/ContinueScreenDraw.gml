function ContinueScreenDraw()
{
	// Draw text
	draw_set_font(game_font(font_card)); 
	draw_set_halign(fa_center);
	
	draw_text(RoomX + 7, RoomY - 49, "CONTINUE");
	
	// Draw countdown
	draw_set_font(game_font(font_counter)); 
	draw_set_halign(fa_center);
	
	draw_text(RoomX + 3, RoomY + 12, (Countdown > 599) ? "10" : "0" + string(Countdown div 60));
	
	// Draw stars
	draw_sprite(tex_continue_stars, 0, RoomX - 1, RoomY + 12);
}