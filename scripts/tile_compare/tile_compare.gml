/// @function tile_compare(data1,data2,objectAngle)
function tile_compare(data1,data2,objectAngle)
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
	if objectAngle != noone and !Game.S1FloorCollision
	{
		// Use cardinal angle if difference is higher than 45
		var Difference = abs(objectAngle mod 180 - ResultAngle mod 180);		
		if  Difference > 45 and Difference < 135
		{
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