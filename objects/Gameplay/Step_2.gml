/// @description
// You can write your code in this editor
	
	// Player Scripts
	#region Player
	{
		// Check if we should run the code below
		if PlayerProcess()
		{	
			PlayerPowerup();
			PlayerSuperFormsProcess();
			PlayerWaterEvents();
			PlayerSwapPhysics();
			PlayerPositionRecord();
			PlayerAnimate();
			PlayerRotation();
		}
	}
	#endregion
	
	// Camera Scripts
	#region Camera
	{
		ScreenCameraFollowProcess();
		ScreenCameraOffsetsProcess();
		ScreenCameraUpdate();
	}
	#endregion
	
	// Stage Scripts
	#region Stage
	{
		StageActiveProcess();
		StageObjectsActiveProcess();
		StageBoundariesProcess();
		StageEndProcess();
	}
	#endregion