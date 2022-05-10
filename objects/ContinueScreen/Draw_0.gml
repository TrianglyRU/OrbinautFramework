/// @description Draw
// You can write your code in this editor
	
	// Draw text
	draw_set_font(Font.FontCard); 
	draw_set_halign(fa_center);
	
	draw_text(RoomX + 8, RoomY - 49, "CONTINUE");
	
	// Draw countdown
	draw_set_font(Font.FontDigits1); 
	draw_set_halign(fa_center);
	
	draw_text(RoomX + 3, RoomY + 12, (Countdown > 599) ? "10" : "0" + string(Countdown div 60));
	
	// Draw stars
	draw_sprite(tex_continue_stars, 0, RoomX - 1, RoomY + 12);