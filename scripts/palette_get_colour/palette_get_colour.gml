/// @function palette_get_colour(paletteType,id)
function palette_get_colour(paletteType, id)
{
	// Return colour
	if paletteType == PaletteDry
	{
		return Palette.IndexDry[id];
	}
	else if paletteType == PaletteWet
	{
		return Palette.IndexWet[id];
	}
}