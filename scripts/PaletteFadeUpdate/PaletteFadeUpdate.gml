function PaletteFadeUpdate()
{	
	// Exit if paused
	if instance_exists(Stage) and Stage.GamePaused
	{
		exit;
	}
	
	// Turn off palette fade if it is disabled
	if !FadeEnabled
	{ 
		FadeStep = FadeColour == flash ? 1008 : 756;
	} 
	
	// If palette fade is enabled
	else 
	{
		// Update every step when active
		if FadeTimer > 0 
		{
			var Pow = 36 * FadePower;
			FadeTimer--; 
			FadeStep = clamp(FadeStep + (FadeMode ? Pow : -Pow), 0, (FadeColour == flash ? 1008 : 756));
		}
	}	
}