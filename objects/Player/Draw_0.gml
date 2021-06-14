/// @description Render
// You can write your code in this editor
	
	// Exit the code if stage is loading or unloading
	if Stage.GamePaused or Stage.State == ActStateLoading or Stage.State == ActStateUnload
	{
		exit;
	}
	
	// Execute code based on current state
	if !DebugMode
	{
		// Animate character
		PlayerAnimate();
	
		// Display character
		PlayerDisplay();
	}
	else
	{
		// Display objects when in debug mode
		PlayerDebugModeDisplay();
	}
	
	
	