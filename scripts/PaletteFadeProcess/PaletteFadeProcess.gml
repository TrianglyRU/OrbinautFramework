function PaletteFadeProcess()
{	
	// Exit if we're in playable stage and it is paused
	if instance_exists(Stage) and Stage.State == StagePaused
	{
		exit;
	}
	
	// Update fade
	if FadeTimer > 0 
	{
		var Step = 36 * FadePower;	 
		FadeStep = clamp(FadeStep + (FadeMode ? Step : -Step), 0, FadeColour == FadeFlash ? 1008 : 756);
		FadeTimer--;
	}
}