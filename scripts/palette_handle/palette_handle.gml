/// @function palette_handle(type,id,last,goto,duration)
function palette_handle(type, id, last, goto, duration)
{
	// Get colour index
	var index = max(0, id - 1);
	var cycle = max(1, goto);
	
	// Get unique ID
	var AnimationID = string(last) + "_" + string(goto);
	
	// Initialize or update palette animation
	if PaletteSequence[type,index] != AnimationID
	{
		// Set data
		PaletteSequence[type,index] = AnimationID;
		PaletteDuration[type,index]	= duration;
	}
	else if duration > 1
	{
		// Decrease the value of animation timer
		if PaletteDuration[type,index] > 1
		{
			PaletteDuration[type,index]--;
		}
		else
		{
			// Reset duration
			PaletteDuration[type,index] = duration;
		
			// Update colour
			if type == PaletteSurface
			{
				if PaletteIndexDry[index] < last
				{
					PaletteIndexDry[index]++;
				}
				else
				{
					PaletteIndexDry[index] = cycle;
				}
			}
			else if type == PaletteUnderwater
			{
				if PaletteIndexWet[index] < last
				{
					PaletteIndexWet[index]++;
				}
				else
				{
					PaletteIndexWet[index] = cycle;
				}
			}
			
		}
	}
}