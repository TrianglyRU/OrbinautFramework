function PlayerProcess()
{
	if DebugMode or Stage.IsPaused or fade_check(StateActive)
	{
		return false;
	}
	return true;
}