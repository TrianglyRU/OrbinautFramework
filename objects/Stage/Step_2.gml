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
	
	if Stage.Time mod 30 == 0
	{
		instance_create(floor(Player.PosX), floor(Player.PosY), Bubble);
	}
	//show_debug_message("TargetLeft: " + string(TargetLeftBoundary));
	//show_debug_message("ActualLeft: " + string(LeftBoundary));
	//show_debug_message("TargetBottom: " + string(TargetBottomBoundary));
	//show_debug_message("ActualBottom: " + string(BottomBoundary));