/// @function palette_get_colour(type,id)
function palette_get_colour(type, id)
{
	// Get actual index
	var Index = max(0, id - 1);
	
	// Return colour
	if type == PaletteDry
	{
		return Palette.IndexDry[Index];
	}
	else if type == PaletteWet
	{
		return Palette.IndexWet[Index];
	}
}