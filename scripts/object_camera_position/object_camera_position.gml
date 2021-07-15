/// @function object_camera_position(obj)
function object_camera_position(obj)
{
	// Get X position
	if variable_instance_exists(obj, "PosX")
	{
		var XPos = floor(PosX) - Screen.CameraX;
	}
	else
	{
		var XPos = floor(x) - Screen.CameraX;
	}
	
	// Get Y position
	if variable_instance_exists(obj, "PosX")
	{
		var YPos = floor(PosY) - Screen.CameraY;
	}
	else
	{
		var YPos = floor(y) - Screen.CameraY;
	}
	
	//XPos = clamp(XPos, 0, Screen.Width);
	//YPos = clamp(YPos, 0, Screen.Height);
	
	// Retrun
	return [XPos, YPos];
}