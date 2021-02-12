/// @function string_set_font(font, align)
function string_set_font(font, align) 
{
	draw_set_font(font);
	
	if align != "left" and align != "right" and align != "centre"
	{
		show_message("Wrong align attribute set for function string_set_font! Expected 'left', 'right' or 'centre'");
		game_end();
	}
	switch align 
	{
		case "left": draw_set_halign(fa_left)     break;
		case "right": draw_set_halign(fa_right)   break;
		case "centre": draw_set_halign(fa_center) break;
	}
}