/// @function palette_handle(paletteType,id,range,last,goto,duration)
function palette_handle(paletteType,id,range,last,goto,duration)
{
	// Get unique ID
	var SequenceID = string(last) + "_" + string(goto);
	
	// Initialise or update palette shift
	if Palette.Sequence[paletteType,id] != SequenceID
	{
		Palette.Sequence[paletteType,id] = SequenceID;
		Palette.Duration[paletteType,id] = duration;
	}
	else if duration > 1
	{
		// If fade is active or stage is paused, do not update
		if !fade_check(FadeActive) and !variable_check(Stage, "IsPaused")
		{
			// Decrease the value of animation timer
			if (--Palette.Duration[paletteType,id]) < 1
			{
				var Bound  = max(1, goto);
				var Amount = id + range;
			
				// Reset duration
				Palette.Duration[paletteType,id] = duration;
			
				// Update colour(s)
				for (var i = id; i < Amount; i++)
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