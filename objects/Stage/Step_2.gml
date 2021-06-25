/// @description Stage Scripts
// You can call your scripts in this editor	
	
	if (GamePaused) exit;
	
	// Update stage
	StageActUpdate();
	
	// Update objects
	StageObjectsUpdate();
	
	// Update boundaries
	StageBoundariesUpdate();
	
	// Check for unloading the stage
	StageActUnload();
	
	//show_debug_message("TargetLeft: " + string(TargetLeftBoundary));
	//show_debug_message("ActualLeft: " + string(LeftBoundary));
	//show_debug_message("TargetBottom: " + string(TargetBottomBoundary));
	//show_debug_message("ActualBottom: " + string(BottomBoundary));