/// @function palette_update_colour(Pal?,iCol,rCol1,rCol2,duration)
function palette_update_colour(palType,iCol,rCol1,rCol2,duration)
{
	if Palette.ColourSet[palType] == false or !Renderer.UpdateAnimations
	{
		return;
	}
	
	// Get unique ID for this palette sequence
	var SequenceID = string(rCol1) + "_" + string(rCol2);
	
	// Initialise palette sequence
	if Palette.Sequence[palType][iCol] != SequenceID
	{
		Palette.Sequence[palType][iCol] = SequenceID;
		Palette.Duration[palType][iCol] = duration;
		Palette.SwapTime[palType][iCol] = duration;
	}
	
	// Update sequence
	if duration
	{
		if !(--Palette.SwapTime[palType,iCol])
		{
			// Update colour
			if palType == PalPrimary
			{
				if (++Palette.IndexType1[iCol]) > rCol1
				{
					Palette.IndexType1[iCol] = rCol2;
				}
			}
			else if palType == PalSecondary
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