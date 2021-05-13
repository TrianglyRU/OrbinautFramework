/// @description Render
// You can write your code in this editor
	
	// Do not run this code if stage is loading, unloading or restarting
	if (Stage.State == ActStateLoading or Stage.State == ActStateUnload or Stage.State == ActStateRestart) exit;
	
	// Animate character
	PlayerAnimate();
	
	// Display character
	PlayerDisplay();
	
	// Display objects when in debug mode
	PlayerDebugModeDisplay();