/// @function palette_handle(paletteType,id,range,last,goto,duration)
function palette_handle(paletteType,id,range,last,goto,duration)
{
	// Get colour index
	var index = max(0, id - 1);
	
	// Get unique ID
	var AnimationID = string(last) + "_" + string(goto);
	
	// Initialise or update palette shift
	if Palette.Sequence[paletteType,index] != AnimationID
	{
		Palette.Sequence[paletteType,index] = AnimationID;
		Palette.Duration[paletteType,index] = duration;
	}
	else if duration > 1
	{
		// If fade is active or stage is paused, do not update
		if !fade_check(FadeActive) and !variable_check(Stage, "IsPaused")
		{
			// Decrease the value of animation timer
			if (--Palette.Duration[paletteType,index]) < 1
			{
				var Bound  = max(1, goto);
				var Amount = index + range;
			
				// Reset duration
				Palette.Duration[paletteType,index] = duration;
			
				// Update colour(s)
				for (var i = index; i < Amount; i++)
				{
					if paletteType == PaletteDry
					{
						if (++Palette.IndexDry[i]) > last
						{
							Palette.IndexDry[i] = Bound;
						}
					}
					else if paletteType == PaletteWet
					{
						if (++Palette.IndexWet[i]) > last
						{
							Palette.IndexWet[i] = Bound;
						}
					}
				}
			}
		}
	}
}