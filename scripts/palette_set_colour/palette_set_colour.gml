/// @function palette_set_colour(type, id, colourid)
function palette_set_colour(type, id, colourid)
{
	if type == PaletteSurface
	{
		PaletteIndexDry[id - 1] = colourid;
	}
	else if type = PaletteUnderwater
	{
		PaletteIndexWet[id - 1] = colourid;
	}
}