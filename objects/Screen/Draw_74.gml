/// @description
// You can write your code in this editor
	
	// Call pause process script, exit further code if active
	if ScreenPauseProcess() exit;
	
	// Call renderer process script
	ScreenRendererLowProcess();
	
	// Call HUD process script
	ScreenInterfaceProcess();

	// Call results process script
	ScreenResultsProcess();
	
	// Call renderer update script
	ScreenRendererUpdate();
	
	// Call renderer process script
	ScreenRendererHighProcess();
	
	// Call card process script
	ScreenCardProcess();
		
	// Call renderer update script
	ScreenRendererUpdate();