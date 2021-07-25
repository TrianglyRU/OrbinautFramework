function PlayerProcess()
{
	// Do not proceed
	if Stage.GamePaused or Stage.State == ActStateLoading or Stage.State == ActStateUnload or DebugMode
	{
		return false;
	}
	
	// Proceed
	return true;
}