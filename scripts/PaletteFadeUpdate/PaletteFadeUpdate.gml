function PaletteFadeUpdate()
{	
	// Turn off fade if disabled
	if !Palette.FadeEnabled
	{ 
		Palette.FadeStep = Palette.FadeColour == flash ? 1008 : 756;
	} 
	
	// Update fade state every tick
	else 
	{
		if Palette.FadeTimer > 0 
		{
			var Pow = 36 * Palette.FadePower;
			Palette.FadeTimer--; 
			Palette.FadeStep = clamp(Palette.FadeStep + (Palette.FadeMode ? Pow : -Pow), 0, (Palette.FadeColour == flash ? 1008 : 756));
		}
	}	
}