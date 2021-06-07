/// @description Insert description here
// You can write your code in this editor
	
	if object_player_overlap(CollisionTriggerbox)
	{
		Stage.BottomBoundary = BottomBoundary;
		Screen.LimitScrollY  = CameraSpeed;
	}
	
	// Restore default value when the camera catch up
	if Screen.MaxRenderY == Stage.BottomBoundary
	{
		Screen.LimitScrollY = BaseSpeed;
	}