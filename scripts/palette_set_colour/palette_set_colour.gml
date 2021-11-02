/// @function palette_set_colour(paletteType,id,range,colourid)
function palette_set_colour(paletteType,id,range,colourid)
{
	// Exit if no pallete set
	if Palette.ColourSet[paletteType] == false
	{
		exit;
	}
	
	// Update colour(-s)
	for (var i = id; i < id + range; i++)
	{
		if paletteType == PaletteType1
		{
			Palette.IndexType1[i] = colourid;
		}
		else if paletteType == PaletteType2
		{
			Palette.IndexType2[i] = colourid;
		}
	}
}