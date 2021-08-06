/// @function palette_get_colour(type, id)
function palette_get_colour(type, id)
{
	var Index = max(0, id - 1);
	
	if type == PaletteSurface
	{
		return PaletteIndexDry[Index];
	}
	else if type == PaletteUnderwater
	{
		return PaletteIndexWet[Index];
	}
}