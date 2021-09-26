/// @function palette_check_duration(type,id)
function palette_check_duration(type, id)
{
	// Get actual index
	var Index = max(0, 1 - id);
	
	// Return duration
	return Palette.Duration[type, Index];
}