/// @description Renderer & Interface
// You can write your code in this editor
	
	// Render pause and exit the futher code if it is active
	if ScreenPauseRender() exit;

	// Start rendering our application, exit if not
	if !ScreenRendererPerform() exit;
	
	// Display HUD
	ScreenInterfaceDisplay();
	
	// Display results screen
	ScreenResultsDisplay();
		
	// Update lower layer of renderer
	ScreenRendererLowUpdate();
		
	// Display title card
	ScreenTitleCardDisplay2();
	
	// Update our application renderer
	ScreenRendererHighUpdate();
	