/// @function palette_handle(type,index,startid,colours,duration)
function palette_handle(type, index, startid, colours, duration)
{
	// Initialize palette animation
	if PaletteAnimation[type,index] == noone
	{
		PaletteTimer[type,index]     = duration;
		PaletteColour[type,index]    = startid;
		PaletteAnimation[type,index] = startid;
	}
	
	// Exit if screen is fading
	if FadeTimer
	{
		exit;
	}
	
	// Check if palette animation has changed
	if startid != PaletteAnimation[type,index]
	{
		PaletteTimer[type,index]     = duration;
		PaletteColour[type,index]    = startid;
		PaletteAnimation[type,index] = startid;
	}
	else
	{
		// Decrease the value of animation timer
		if PaletteTimer[type,index] > 1
		{
			PaletteTimer[type,index]--;
		}
		else
		{
			// Reset duration
			PaletteTimer[type,index] = duration;
		
			// Shift colour
			if PaletteColour[type,index] < startid + colours - 1
			{
				PaletteColour[type,index]++;
			}
			else
			{
				PaletteColour[type,index] = startid;
			}
		}	
	}
	
	// Apply colour
	if type == PaletteUnderwater
	{
		PalIndexWet[index] = PaletteColour[type,index];
	}
	else if type == PaletteSurface
	{
		PalIndexDry[index] = PaletteColour[type,index];
	}
	
	// Perform colour shift
	//var current_colour = Game.SmoothPaletteCycle ? Stage.AnimationTime / duration : floor(Stage.AnimationTime / duration);
	//var shift = colours ? loop_value(current_colour, startid, startid + colours) : 1;
}