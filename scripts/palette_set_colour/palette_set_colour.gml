/// @function palette_set_colour(type,id,range,colourid)
function palette_set_colour(type, id, range, colourid)
{
	// Get colour
	var LastColour = id - 1 + range;
	
	// Update colour
	for (var i = id - 1; i < LastColour; i++)
	{
		if type == PaletteDry
		{
			Palette.IndexDry[i] = colourid;
		}
		else if type == PaletteWet
		{
			Palette.IndexWet[i] = colourid;
		}
	}
}