/// @function palette_handle_range(palType,iCol1,iCol2,rCol1,rCol2,duration)
function palette_handle_range(palType,iCol1,iCol2,rCol1,rCol2,duration)
{
	// Exit if no pallete set, playable stage is paused or fade is active
	if Palette.ColourSet[palType] == false or variable_check(Stage, "IsPaused") or fade_check(StateActive)
	{
		exit;
	}
	
	// Get unique ID for this palette sequence
	var SequenceID = string(rCol1) + "_" + string(rCol2);
	
	// Initialise palette sequence
	if Palette.Sequence[palType][iCol1] != SequenceID
	{
		Palette.Sequence[palType][iCol1] = SequenceID;
		Palette.Duration[palType][iCol1] = duration;
		Palette.SwapTime[palType][iCol1] = duration;
	}
	
	// Update sequence
	else if duration
	{
		if !(--Palette.SwapTime[palType,iCol1])
		{
			// Update colours
			for (var i = iCol1; i <= iCol2; i++)
			{
				if palType == TypePrimary
				{
					if (++Palette.IndexType1[i]) > rCol1
					{
						Palette.IndexType1[i] = rCol2;
					}
				}
				else if palType == TypeSecondary
				{
					if (++Palette.IndexType2[i]) > rCol1
					{
						Palette.IndexType2[i] = rCol2;
					}
				}
			}
			
			// Reset duration
			Palette.SwapTime[palType,iCol1] = Palette.Duration[palType,iCol1];
		}
	}
}