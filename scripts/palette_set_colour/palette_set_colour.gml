/// @function palette_set_colour(forPalType,rowID,toColumnID)
function palette_set_colour(forPalType,atRowID,toColumnID)
{
	if Palette.ColourSet[forPalType] == false or !Renderer.UpdateAnimations
	{
		return;
	}
	
	/* Reference our 2d array. YoYo freaked up their YYC compiler with one
	of the latest updates it is now crashing if not referenced. */
	var A = Palette.Duration[forPalType,atRowID];
	
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
	if Palette.Duration[forPalType,atRowID] != noone
	{
		Palette.SwapTime[forPalType,atRowID] = Palette.Duration[forPalType,atRowID];
	}
}