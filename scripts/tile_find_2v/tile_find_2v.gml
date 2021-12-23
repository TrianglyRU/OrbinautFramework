/// @function tile_find_2v(x1,y1,x2,y2,toPositive,ignoreTop,objectAngle,tilelayer)
function tile_find_2v(x1,y1,x2,y2,toPositive,ignoreTop,objectAngle,tilelayer)
{
	// Get tiles
	var FindTile1 = tile_find_v(x1, y1, toPositive, ignoreTop, tilelayer);
	var FindTile2 = tile_find_v(x2, y2, toPositive, ignoreTop, tilelayer);
	
	// Check which tile we should use
	if FindTile1[0] <= FindTile2[0]
	{
		var ResultDistance = FindTile1[0];
		var ResultAngle	   = FindTile1[1];
	}
	
	// Else use the right tile
	else	
	{
		var ResultDistance = FindTile2[0];
		var ResultAngle	   = FindTile2[1];
	}
	
	// If object angle is defined, use cardinal one if difference is higher than 45
	if objectAngle != noone and !Game.S1FloorCollision
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