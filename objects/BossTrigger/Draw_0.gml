/// @description Draw
// You can write your code in this editor
	
	if !(Template and Stage.IsBossfight)
	{
		return;
	}
	
	// Draw text
	draw_set_font(Font.FontDefault);
	draw_set_halign(fa_center);
	
	draw_text(x, y, "*BOSSFIGHT TEMPLATE!*");
	draw_text(x, y + 16, "PRESS K ON THE KEYBOARD TO FINISH");
	draw_text(x, y + 26, "THE BOSSFIGHT");