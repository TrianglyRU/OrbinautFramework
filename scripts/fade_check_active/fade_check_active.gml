function fade_check_active(mode, colour)
{
	if Palette.FadeMode == mode and Palette.FadeColour = colour
	{
		return Palette.FadeStep != 756;
	}
	else
	{
		return false;
	}
}