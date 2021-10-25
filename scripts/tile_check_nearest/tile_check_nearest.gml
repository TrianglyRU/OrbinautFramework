/// @function tile_check_nearest(data1,data2,objectAngle)
function tile_check_nearest(data1,data2,objectAngle)
{
	// Use the left tile
	if data1[0] <= data2[0]
	{
		var ResultDistance = data1[0];
		var ResultAngle	   = data1[1];
	}
	
	// Else use the right tile
	else	
	{
		var ResultDistance = data2[0];
		var ResultAngle	   = data2[1];
	}
	
	// Is object angle defined?
	if objectAngle != noone
	{
		// Use cardinal angle if difference is higher than 45
		var Difference = abs(objectAngle mod 180 - ResultAngle mod 180);		
		if  Difference > 45 and Difference < 135
		{
			/* Originals also check for a bit flag set for tiles with angle
			0xFF, but we already handle it right when we get tile data */
			   
			ResultAngle = round(objectAngle / 90) mod 4 * 90;
			if !ResultAngle
			{
				ResultAngle = 360;
			}
		}
	}
	
	// Return data
	return [ResultDistance, ResultAngle];
}