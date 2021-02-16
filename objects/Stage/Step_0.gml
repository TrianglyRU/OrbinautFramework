/// @description Stage Scripts
// You can call your scripts in this editor	

	// Update stage and its palette cycles
	StageActUpdate();
	
	// Handle stage music
	StageMusicUpdate();
	
	// Update boundaries
	StageBoundariesUpdate();
	
	// Unload objects outside of our view
	StageObjectsUnload();