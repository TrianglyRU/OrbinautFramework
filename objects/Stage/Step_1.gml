/// @description Stage Scripts
// You can call your scripts in this editor	

	// Update stage
	StageActUpdate();
	
	// Handle stage music
	StageMusicUpdate();
	
	// Update boundaries
	StageBoundariesUpdate();
	
	// Update objects
	StageObjectsUpdate();
	
	// Check for unloading the stage
	StageActEnd();