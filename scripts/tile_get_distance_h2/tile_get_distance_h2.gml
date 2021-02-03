/// @function tile_get_distance_h2(xStart, yStart, toPositive, onlyFullsolid)
function tile_get_distance_h2(xStart, yStart, toPositive, onlyFullsolid)
{	
	// Set adjustable coordinates
	var X = xStart;
	var Y = yStart;
	var maxDistance = Grounded * (TileSize * 2)
	
	// Find distance to the right
	if toPositive
	{
		while !tile_meeting(X, Y, Layer) and X < xStart + maxDistance
		{
			X++;
		}
		while tile_meeting(X, Y, Layer)
		{
			X--;
		}
		return X - xStart;
	}
	
	// Find distance to the left
	else
	{
		while !tile_meeting(X, Y, Layer) and X > xStart - maxDistance
		{
			X--;
		}
		while tile_meeting(X, Y, Layer)
		{
			X++;
		}
		return xStart - X;
	}
}