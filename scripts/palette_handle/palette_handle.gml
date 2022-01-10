/// @function palette_handle(paletteType,iCol,rCol1,rCol2,duration)
function palette_handle(palType,iCol,rCol1,rCol2,duration)
{
	// Exit if no pallete set, playable stage is paused or fade is active
	if Palette.ColourSet[palType] == false or variable_check(Stage, "IsPaused") or fade_check(StateActive)
	{
		exit;
	}
	
	// Get unique ID for this palette sequence
	var SequenceID = string(rCol1) + "_" + string(rCol2);
	
	// Initialise palette sequence
	if Palette.Sequence[palType][id] != SequenceID
	{
		Palette.Sequence[palType][id] = SequenceID;
		Palette.Duration[palType][id] = duration;
		Palette.SwapTime[palType][id] = duration;
	}
	
	// Update sequence
	else if duration
	{
		if !(--Palette.SwapTime[palType,iCol])
		{
			// Update colour
			if palType == TypePrimary
			{
				if (++Palette.IndexType1[iCol]) > rCol1
				{
					Palette.IndexType1[iCol] = rCol2;
				}
			}
			else if palType == TypeSecondary
			{
				if (++Palette.IndexType2[iCol]) > rCol1
				{
					Palette.IndexType2[iCol] = rCol2;
				}
			}
			
			// Reset duration
			Palette.SwapTime[palType,iCol] = Palette.Duration[palType,iCol];
		}
	}
}