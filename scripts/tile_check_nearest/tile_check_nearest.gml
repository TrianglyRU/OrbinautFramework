/// @function tile_check_nearest(leftdata,rightdata,object_angle)
function tile_check_nearest(leftdata,rightdata,object_angle)
{
	// Use the left tile
	if leftdata[0] <= rightdata[0]
	{
		var ResultDistance = leftdata[0];
		var VisualAngle	   = leftdata[1];
	}
	
	// Else use the right tile
	else	
	{
		var ResultDistance = rightdata[0];
		var VisualAngle	   = rightdata[1];
	}
	
	// Is object angle defined?
	if object_angle != noone
	{
		// Get the difference between object current angle and floor angle
		var Difference = abs(object_angle mod 180 - VisualAngle mod 180);
		
		// Use cardinal angle if difference is higher than 45
		if Difference > 45 and Difference < 135
		{
			/* The originals also check for a bit flag set for tiles with angle
			   0xFF, but we handle it right when we get tile data to make it more stable */
			   
			var VisualAngle = round(object_angle / 90) mod 4 * 90;
			if !VisualAngle
			{
				VisualAngle = 360;
			}
		}
	}
	
	// Return data
	return [ResultDistance, VisualAngle];
}