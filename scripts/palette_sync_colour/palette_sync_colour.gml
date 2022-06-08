/// @function palette_sync_colour(onPalType,fromRowID,toRowID,withPalType,usingRowID)
function palette_sync_colour(onPalType,fromRowID,toRowID,withPalType,usingRowID)
{
	// Get current colour
	var Colour = palette_get_colour(withPalType, usingRowID);
	
	// Update colour(s)
	for (var i = fromRowID; i <= toRowID; i++)
	{
		palette_set_colour(onPalType, i, Colour);
	}
}