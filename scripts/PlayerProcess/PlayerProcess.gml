function PlayerProcess()
{
	// Do not process player events if something of the following is happening
	if DebugMode or Stage.IsPaused or fade_check(StateActive)
	{
		return false;
	}
	
	// ...else process!
	return true;
}