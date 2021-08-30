/// @function palette_handle(type,id,range,last,goto,duration)
function palette_handle(type, id, range, last, goto, duration)
{
	// Get colour index
	var index = max(0, id - 1);
	
	// Get unique ID
	var AnimationID = string(last) + "_" + string(goto);
	
	// Initialise or update palette animation
	if Palette.Sequence[type,index] != AnimationID
	{
		// Set data
		Palette.Sequence[type,index] = AnimationID;
		Palette.Duration[type,index] = duration;
	}
	else if duration > 1 and !fade_check(FadeActive)
	{
		// Decrease the value of animation timer
		if (--Palette.Duration[type,index]) < 1
		{
			var cycle = max(1, goto);
			var lastanim = index + range;
			
			// Reset duration
			Palette.Duration[type,index] = duration;
			
			// Update colour
			for(var i = index; i < lastanim; i++)
			{
				if type == PaletteDry
				{
					if (++Palette.IndexDry[i]) > last
					{
						Palette.IndexDry[i] = cycle;
					}
				}
				else if type == PaletteWet
				{
					if (++Palette.IndexWet[i]) > last
					{
						Palette.IndexWet[i] = cycle;
					}
				}
			}
		}
	}
}