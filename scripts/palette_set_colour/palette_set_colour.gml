/// @function palette_set_colour(Pal?,iCol,rCol)
function palette_set_colour(palType,iCol,rCol)
{
	if Palette.ColourSet[palType] == false or !Renderer.UpdateAnimations
	{
		return;
	}
	
	// Update colour
	if palType == PalPrimary
	{
		Palette.IndexType1[iCol] = rCol;
	}
	else if palType == PalSecondary
	{
		Palette.IndexType2[iCol] = rCol;
	}
		
	// Reset swaptime
	if Palette.Duration[palType,iCol] != noone
	{
		Palette.SwapTime[palType,iCol] = Palette.Duration[palType,iCol];
	}
}