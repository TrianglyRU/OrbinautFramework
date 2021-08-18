/// @description
// You can write your code in this editor
	
	// Player Scripts
	#region Player
	{
		PlayerVariables();
		PlayerSetup();
		PlayerDebugModeSetup();
	}
	#endregion
	
	// Screen Scripts
	#region Screen
	{
		ScreenVariables();
		ScreenCameraStartup();
		ScreenInterfaceStartup();
		ScreenGameOverStartup();
		ScreenPauseStartup();
		ScreenCardStartup();
		ScreenResultsStartup();
	}
	#endregion
	
	// Camera Scripts
	#region Camera
	{
		CameraVariables();
		ScreenCameraStartup();
	}
	#endregion
	
	// Stage Scripts
	#region Stage
	{
		StageVariables();
		StageSetup();
		StageStartup();
	}
	#endregion
	
	// Background Scripts
	#region Background
	{
		BackgroundVariables();
		BackgroundSetup();
		BackgroundStartup();
	}
	#endregion
	