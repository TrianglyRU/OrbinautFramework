function PlayerProcess()
{
	// Do not process if stage is not updating or fade is active
	if Stage.IsPaused or Stage.IsGameOver or fade_check(FadeActive)
	{
		return false;
	}
	
	// Else process
	return true;
}