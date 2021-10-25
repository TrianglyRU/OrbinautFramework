/// @function palette_set_colour(paletteType,id,range,colourid)
function palette_set_colour(paletteType,id,range,colourid)
{
	// Update colour
	for (var i = id; i < id + range; i++)
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