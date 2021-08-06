function PlayerProcess()
{
	// Do not process if stage is paused or fade is currently active
	if Stage.IsPaused or fade_check(FadeActive)
	{
		return false;
	}
	
	// Else process
	return true;
}