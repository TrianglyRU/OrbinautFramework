function ScreenPaletteFadeUpdate()
{	
	// Exit if paused
	if Stage.GamePaused
	{
		exit;
	}
	
	// Turn off palette fade if it is disabled
	if !Palette.FadeEnabled
	{ 
		Palette.FadeStep = Palette.FadeColour == flash ? 1008 : 756;
	} 
	
	// If palette fade is enabled
	else 
	{
		// Update every step when active
		if Palette.FadeTimer > 0 
		{
			var Pow = 36 * Palette.FadePower;
			Palette.FadeTimer--; 
			Palette.FadeStep = clamp(Palette.FadeStep + (Palette.FadeMode ? Pow : -Pow), 0, (Palette.FadeColour == flash ? 1008 : 756));
		}
	}	
}