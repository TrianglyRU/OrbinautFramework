/// @function palette_get_colour(paletteType,id)
function palette_get_colour(paletteType, id)
{
	// Return first colour if no pallete set
	if Palette.ColourSet[paletteType] == false
	{
		return 0;
	}
	
	// Return colour
	if paletteType == PaletteType1
	{
		return Palette.IndexType1[id];
	}
	else if paletteType == PaletteType2
	{
		return Palette.IndexType2[id];
	}
}