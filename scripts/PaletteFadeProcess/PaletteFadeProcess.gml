function PaletteFadeProcess()
{	
	// Update fade
	if  Palette.FadeMode and Palette.FadeStep < 756 
	or !Palette.FadeMode and Palette.FadeStep > 0
	{
		Palette.FadeStep = clamp(Palette.FadeStep + (Palette.FadeMode ? Palette.FadePower : -Palette.FadePower), 0, 756);
	}
}