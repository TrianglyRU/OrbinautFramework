function ScreenInterfaceSetup()
{	
	// Use offset if transitions are disabled, or enabled AND we're in act 1
	if !Game.StageTransitions or Game.StageTransitions and Stage.ActID == 0
	{
		InterfaceEnabled = false;
		InterfaceOffsetX = -120;	
		InterfaceOffsetY = 0;	
	}
	
	// Do not use offset if transitions are enabled and we're not in act 1
	else
	{
		InterfaceEnabled = true;
		InterfaceOffsetX = 0;
		InterfaceOffsetY = 0;
	}
	
	DebugToggle    = false;
	DebugHitboxes  = false;
	DebugSensors   = false;
	DebugSolids    = false;
	DebugVariables = false;
	
	PauseSurface = -1;
}