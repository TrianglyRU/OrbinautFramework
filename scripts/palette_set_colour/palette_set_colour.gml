/// @function palette_set_colour(paletteType,id,range,colourid)
function palette_set_colour(paletteType,id,range,colourid)
{
	// Get colour
	var LastColour = id - 1 + range;
	
	// Update colour
	for (var i = id - 1; i < LastColour; i++)
	{
		if paletteType == PaletteDry
		{
			Palette.IndexDry[i] = colourid;
		}
		else if paletteType == PaletteWet
		{
			Palette.IndexWet[i] = colourid;
		}
	}
}