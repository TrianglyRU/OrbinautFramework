/// @function tile_find_2h(x1,y1,x2,y2,toPositive,objectAngle,tilelayer)
function tile_find_2h(x1,y1,x2,y2,toPositive,objectAngle,tilelayer)
{
	// Get tiles at positions
	var FindTile1 = tile_find_h(x1, y1, toPositive, tilelayer);
	var FindTile2 = tile_find_h(x2, y2, toPositive, tilelayer);
	
	// Use closest tile
	if FindTile1[0] <= FindTile2[0]
	{
		var ResultDistance = FindTile1[0];
		var ResultAngle	   = FindTile1[1];
	}
	else	
	{
		var ResultDistance = FindTile2[0];
		var ResultAngle	   = FindTile2[1];
	}
	
	// If object angle is defined, reset angle to cardinal one if difference is greater than 45 degrees
	if objectAngle != noone and global.S2FloorCollision
	{
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