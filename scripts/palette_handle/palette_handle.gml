/// @function palette_handle(type,index,startid,colours,duration)
function palette_handle(type, index, startid, colours, duration)
{
	// Smooth palette cycle if framework settings says so
	var current_colour = Game.SmoothPaletteCycle ? Stage.AnimationTime / duration : floor(Stage.AnimationTime / duration);
	
	// Perform colour shift
	var shift = colours ? (startid ? loop_value_range(current_colour, startid, colours) : loop_value(current_colour, colours)) + 1 : 1;
	if  type == PaletteUnderwater
	{
		Palette.PalIndexWet[index] = shift;
	}
	else if type == PaletteSurface
	{
		Palette.PalIndexDry[index] = shift;
	}
}