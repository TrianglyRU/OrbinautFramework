/// @function palette_set_colour_range(Pal?,iCol1,iCol2,rCol)
function palette_set_colour_range(palType,iCol1,iCol2,rCol)
{
	if Palette.ColourSet[palType] == false or !Game.UpdateAnimations
	{
		return;
	}
	
	// Update colours
	for (var i = iCol1; i <= iCol2; i++)
	{
		if palType == PalPrimary
		{
			Palette.IndexType1[i] = rCol;
		}
		else if palType == PalSecondary
		{
			Palette.IndexType2[i] = rCol;
		}
	}
		
	// Reset swaptime
	if Palette.Duration[palType,iCol1] != noone
	{
		Palette.SwapTime[palType,iCol1] = Palette.Duration[palType,iCol1];
	}
}