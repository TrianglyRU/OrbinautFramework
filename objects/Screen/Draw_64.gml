/// @description Renderer & Interface
// You can write your code in this editor
	
	// Render pause and exit the futher code if it is active
	if ScreenStagePauseRender() exit;

	if surface_exists(Game.CompleteSurf)
	{
		// Start rendering our application, exit if not
		ScreenRendererPerform()
	
		// Display HUD
		ScreenInterfaceDisplay();
	
		// Display results screen
		ScreenResultsDisplay();
		
		// Display title card
		ScreenTitleCardDisplay();
		
		// Update lower layer of renderer
		ScreenRendererLowUpdate();
	
		// Update our application renderer
		ScreenRendererHighUpdate();
	}
	