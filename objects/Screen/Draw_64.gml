/// @description Renderer & Interface
// You can write your code in this editor
	
	// Start rendering our application
	ScreenRendererPerform();
	
	// Display HUD
	ScreenInterfaceDisplay();
	
	// Display results screen
	ScreenResultsDisplay();
	
	// Display title card
	ScreenTitleCardDisplay();
	
	// Update our application renderer
	ScreenRendererUpdate();
	
	/* Everything after this line will render ABOVE the fade and 
	   will use current window resolution instead of game one    */
	
	// Display debug screen
	ScreenDebugScreenDisplay();