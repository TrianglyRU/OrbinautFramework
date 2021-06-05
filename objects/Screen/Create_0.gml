/// @description Variables & Setup
// You can call your scripts in this editor
	
	// Initialize variables
	_ScreenVariables();
	
	// Setup camera
	ScreenCameraSetup();
	
	// Setup HUD
	ScreenInterfaceSetup()
	
	// Setup title card
	ScreenTitleCardSetup();
	
	// Setup results screen
	ScreenResultsSetup();

	// Load a palette set to use in the room
	ScreenPaletteDataLoad();
	
	// Reset fade state
	ScreenPaletteFadeReset();
	
	// Handle static palette
	ScreenPaletteHandleStatic();