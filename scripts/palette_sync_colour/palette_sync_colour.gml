/// @function palette_sync_colour(palType,iCol,rCol)
function palette_sync_colour(palType,iCol,rCol)
{
	// Get current colour
	var Colour = palette_get_colour(palType, iCol);
	
	// Update other colour
	palette_set_colour(palType, rCol, Colour);
}