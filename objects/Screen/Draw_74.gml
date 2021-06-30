/// @description GUI
// You can write your code in this editor
	
	// Render pause and exit the futher code if it is active
	if ScreenPauseDisplay() exit;
	
	// Start render below the fade
	ScreenRendererLowStart();
	
	// Display HUD
	ScreenInterfaceDisplay();
	
	// Display results screen
	ScreenResultsDisplay();
	
	// Update renderer
	ScreenRendererUpdate();
	
	// Start render above the fade
	ScreenRendererHighStart();
	
	// Display title card
	ScreenTitleCardDisplay();
		
	// Update renderer
	ScreenRendererUpdate();