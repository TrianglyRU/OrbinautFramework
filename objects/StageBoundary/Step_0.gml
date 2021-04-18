/// @description Insert description here
// You can write your code in this editor
	
	if object_check_overlap(CollisionTriggerbox)
	{
		Stage.TopBoundary    = TopBoundary;
		Stage.BottomBoundary = BottomBoundary;
		Screen.MinMaxSpeed   = CameraSpeed;
	}