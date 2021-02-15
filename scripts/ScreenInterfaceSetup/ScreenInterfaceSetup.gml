function ScreenInterfaceSetup()
{	
	// Use offset for HUD in act 1
	if Stage.ActID = 0
	{
		InterfaceEnabled = false;
		InterfaceOffsetX = -120;	
		InterfaceOffsetY = 0;	
	}
	
	// Do not use any offsets and enable HUD by default in acts other than act 1
	else
	{
		InterfaceEnabled = true;
		InterfaceOffsetX = 0;	
		InterfaceOffsetY = 0;
	}
	
	// Disable debug screen
	EnableDebug	= false;
}