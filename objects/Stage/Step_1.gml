/// @description Stage Scripts
// You can call your scripts in this editor	

	// Handle stage music
	StageMusicUpdate();
	
	// Update stage
	StageActUpdate();
	
	// Update boundaries
	StageBoundariesUpdate();
	
	// Update objects
	StageObjectsUpdate();
	
	// Check for unloading the stage
	StageActEnd();