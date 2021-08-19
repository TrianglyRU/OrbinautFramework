/// @function object_get_screenpos(obj)
function object_get_screenpos(obj)
{
	// Get position
	var XPos = obj.x - Camera.ViewX;
	var YPos = obj.y - Camera.ViewY;
	
	// Retrun
	return [XPos, YPos];
}