/// @function string_display_new(x,y,string,size,font,halign,valign)
function string_display_new(x, y, string, size, font, halign, valign) 
{
	draw_set_font(font);
	draw_set_halign(halign);
	draw_set_valign(valign)
	draw_text_transformed(x, y, string, size, size, 0);
}