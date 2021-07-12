/// @description Animate & Display
// You can write your code in this editor
	
	// Display objects when in debug mode
	PlayerDebugModeDisplay();
	
	// Check if we should run the code below
	if !PlayerCheckProceed() exit;
	
	// Animate character
	PlayerAnimate();
		
	// Display character
	PlayerDisplay();