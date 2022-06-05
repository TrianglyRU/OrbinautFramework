/// @function palette_set_colour(palType,iCol,rCol)
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
	var Duration  = Palette.Duration[palType,iCol];
	if  Duration != noone
	{
		Palette.SwapTime[palType,iCol] = Duration;
	}
}