function PlayerProcess()
{
	// Do not proceed
	if Stage.State != StageActive or DebugMode
	{
		return false;
	}
	
	// Proceed
	return true;
}