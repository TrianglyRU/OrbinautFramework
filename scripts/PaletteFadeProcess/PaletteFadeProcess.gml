function PaletteFadeProcess()
{	
	// Update fade
	if FadeMode and FadeStep < 756
	{
		FadeStep = min(FadeStep + FadeSpeed, 756);
	}
	else if !FadeMode and FadeStep > 0
	{
		FadeStep = max(FadeStep - FadeSpeed, 0);
	}
}