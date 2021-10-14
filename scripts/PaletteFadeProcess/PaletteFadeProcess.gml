function PaletteFadeProcess()
{	
	// Update fade
	if FadeMode and FadeStep < 756
	{
		FadeStep = min(FadeStep + FadePower, 756);
	}
	else if !FadeMode and FadeStep > 0
	{
		FadeStep = max(FadeStep - FadePower, 0);
	}
}