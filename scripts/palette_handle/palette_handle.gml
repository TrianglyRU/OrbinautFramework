/// @function palette_handle(type,id,range,last,goto,duration)
function palette_handle(type, id, range, last, goto, duration)
{
	// Get colour index
	var index = max(0, id - 1);
	
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
		if --PaletteDuration[type,index] < 1
		{
			var cycle = max(1, goto);
			var lastanim = index + range;
			
			// Reset duration
			PaletteDuration[type,index] = duration;
			
			// Update colour
			for(var i = index; i < lastanim; i++)
			{
				if type == PaletteSurface
				{
					if ++PaletteIndexDry[i] > last
					{
						PaletteIndexDry[i] = cycle;
					}
				}
				else if type == PaletteUnderwater
				{
					if ++PaletteIndexWet[i] > last
					{
						PaletteIndexWet[i] = cycle;
					}
				}
			}
		}
	}
}