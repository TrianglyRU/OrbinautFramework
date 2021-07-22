/// @function palette_handle_bu(type,index,startid,colours,duration)
function palette_handle_bu(type, index, startid, colours, duration)
{
	// Exit if screen is fading
	if FadeTimer
	{
		exit;
	}
	
	// Initialize or update palette animation
	if PaletteAnimation[type,index] == noone
	or PaletteAnimation[type,index] != startid
	{
		// Set data
		PaletteTimer[type,index]     = duration;
		PaletteColour[type,index]    = startid;
		PaletteAnimation[type,index] = startid;
		
		// Apply colour
		if duration == 1
		{
			if type == PaletteUnderwater
			{
				PaletteIndexWet[index] = PaletteColour[type,index];
			}
			else if type == PaletteSurface
			{
				PaletteIndexDry[index] = PaletteColour[type,index];
			}
		}
	}
	else if duration > 1
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
		
		// Update colour
		if type == PaletteUnderwater
		{
			PaletteIndexWet[index] = PaletteColour[type,index];
		}
		else if type == PaletteSurface
		{
			PaletteIndexDry[index] = PaletteColour[type,index];
		}
	}
}