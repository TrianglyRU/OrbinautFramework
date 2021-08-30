function InterfaceVariables()
{
	DebugPositions = 0;
	DebugHelp	   = 0;
	DebugVariables = 0;
	DebugSolids	   = 0;
	DebugHitboxes  = 0;
	DebugTriggers  = 0;
	
	Enabled		   = 0;
	OffsetX		   = 0;
	OffsetY		   = 0;
	PauseValue	   = [];
	CardValue	   = [];
	ResultsValue   = [];
	GameOverValue  = [];
	
	// Force enable help for debug
	if Game.DevMode
	{
		DebugHelp = true;
	}
}