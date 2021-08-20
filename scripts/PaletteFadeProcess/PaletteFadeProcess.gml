function PaletteFadeProcess()
{	
	// Update fade
	if  FadeMode and FadeStep < 756
    or !FadeMode and FadeStep > 0
	{
		FadeStep = clamp(FadeStep + (FadeMode ? FadePower : -FadePower), 0, 756);
	}
}