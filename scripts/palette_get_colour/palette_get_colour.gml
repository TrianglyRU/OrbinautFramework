/// @function palette_get_colour(fromPalType,atRowID)
function palette_get_colour(fromPalType,atRowID)
{
	// Return first colour if no pallete set
	if Palette.ColourSet[fromPalType] == false
	{
		return 0;
	}
	
	// Else return current colour
	if fromPalType == PalPrimary
	{
		return Palette.IndexType1[atRowID];
	}
	else if fromPalType == PalSecondary
	{
		return Palette.IndexType2[atRowID];
	}
}