/// @function palette_get_colour(paletteType,id)
function palette_get_colour(paletteType, id)
{
	// Get actual index
	var Index = max(0, id - 1);
	
	// Return colour
	if paletteType == PaletteDry
	{
		return Palette.IndexDry[Index];
	}
	else if paletteType == PaletteWet
	{
		return Palette.IndexWet[Index];
	}
}