/// @function palette_get_colour(type, id)
function palette_get_colour(type, id)
{
	if type == PaletteSurface
	{
		return PaletteIndexDry[id - 1];
	}
	else if type == PaletteUnderwater
	{
		return PaletteIndexWet[id - 1];
	}
}