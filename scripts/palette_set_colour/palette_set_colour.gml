/// @function palette_set_colour(forPalType,rowID,toColumnID)
function palette_set_colour(forPalType,atRowID,toColumnID)
{
	if Palette.ColourSet[forPalType] == false or !Renderer.UpdateAnimations
	{
		return;
	}
	
	// Update colour
	if forPalType == PalPrimary
	{
		Palette.IndexType1[atRowID] = toColumnID;
	}
	else if forPalType == PalSecondary
	{
		Palette.IndexType2[atRowID] = toColumnID;
	}
	
	// Reset swaptime
	var Duration  = Palette.Duration[forPalType,atRowID];
	if  Duration != noone
	{
		Palette.SwapTime[forPalType,atRowID] = Duration;
	}
}