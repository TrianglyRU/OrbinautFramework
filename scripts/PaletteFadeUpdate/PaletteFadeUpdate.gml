function PaletteFadeUpdate()
{	
	// Exit if paused
	if instance_exists(Stage) and Stage.GamePaused
	{
		exit;
	}
	
	// Update every step when active
	if FadeTimer > 0 
	{
		var Pow = 36 * FadePower;
		FadeTimer--; 
		FadeStep = clamp(FadeStep + (FadeMode ? Pow : -Pow), 0, (FadeColour == flash ? 1008 : 756));
	}
}