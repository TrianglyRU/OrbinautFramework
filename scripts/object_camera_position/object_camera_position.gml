/// @function object_camera_position(obj)
function object_camera_position(obj)
{
	// Get X position
	if variable_instance_exists(obj, "PosX")
	{
		var XPos = floor(PosX) - Camera.ViewX;
	}
	else
	{
		var XPos = floor(x) - Camera.ViewX;
	}
	
	// Get Y position
	if variable_instance_exists(obj, "PosX")
	{
		var YPos = floor(PosY) - Camera.ViewY;
	}
	else
	{
		var YPos = floor(y) - Camera.ViewY;
	}
	
	// Retrun
	return [XPos, YPos];
}