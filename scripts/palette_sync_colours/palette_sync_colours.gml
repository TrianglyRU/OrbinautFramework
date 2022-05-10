/// @function palette_sync_colours(iPalType,iCol,rPalType,rCol1,rCol2)
function palette_sync_colours(iPalType,iCol,rPalType,rCol1,rCol2)
{
	// Get current colour
	var Colour = palette_get_colour(iPalType, iCol);
	
	// Update other colours
	if rCol2 - rCol1 <= 0
	{
		show_debug_message("WARNING: palette_sync_colours called with only one colour selected. Use palette_update_colour() function!");
	}
	else for (var i = rCol1; i <= rCol2; i++)
	{
		palette_set_colour(rPalType, i, Colour);
	}
}