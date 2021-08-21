/// @function palette_get_colour(type, id)
function palette_get_colour(type, id)
{
	var Index = max(0, id - 1);
	
	if type == PaletteDry
	{
		return IndexDry[Index];
	}
	else if type == PaletteWet
	{
		return IndexWet[Index];
	}
}