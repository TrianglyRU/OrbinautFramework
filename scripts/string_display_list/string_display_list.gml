/// @function string_display_list(x, y, string, sep, size)
function string_display_list(X, Y, String, Sep, Size) 
{
	draw_text_ext_transformed(X, Y, String, Sep, 256, Size, Size, 0);
}