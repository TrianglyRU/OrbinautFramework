/// @function palette_check_duration(paletteType,id)
function palette_check_duration(paletteType,id)
{
	// Get actual index
	var Index = max(0, 1 - id);
	
	// Return duration
	return Palette.Duration[paletteType, Index];
}