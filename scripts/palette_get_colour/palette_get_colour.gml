/// @function palette_get_colour(palType,iCol)
function palette_get_colour(palType,iCol)
{
	// Return first colour if no pallete set
	if Palette.ColourSet[palType] == false
	{
		return 0;
	}
	
	// Else return current colour
	if palType == TypePrimary
	{
		return Palette.IndexType1[iCol];
	}
	else if palType == TypeSecondary
	{
		return Palette.IndexType2[iCol];
	}
}