/// @function palette_handle(wet, index, colours, duration)
function palette_handle(wet, index, colours, duration)
{
	// Smooth palette cycle if framework settings says so
	var current_colour = Game.SmoothPaletteCycle ? Stage.AnimationTime / duration : floor(Stage.AnimationTime / duration);
	
	// Perform colour shift
	var shift = colours > 0 ? loop_value(current_colour, colours) + 1 : 1;
	if wet
	{
		Palette.PalIndexWet[index] = shift;
	}
	else 
	{
		Palette.PalIndexDry[index] = shift;
	}
}