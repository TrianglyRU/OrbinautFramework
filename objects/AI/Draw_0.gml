/// @description Render
// You can write your code in this editor
	
	exit;
	
	// Do not run this code if stage is loading, unloading or restarting
	if (Stage.State == ActStateLoading or Stage.State == ActStateUnload or Stage.State == ActStateRestart) exit;
	
	// Animate character
	AIAnimate();
	
	// Display character
	AIDisplay();