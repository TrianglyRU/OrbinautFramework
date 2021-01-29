/// @function string_set_font(font, align)
function string_set_font(font, align) 
{
	draw_set_font(font);
	switch align 
	{
		case "left": draw_set_halign(fa_left)     break;
		case "right": draw_set_halign(fa_right)   break;
		case "centre": draw_set_halign(fa_center) break;
	}
}