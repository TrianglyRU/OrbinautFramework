/// @function tile_get_distance_v2(xStart, yStart, toPositive, onlyFullsolid)
function tile_get_distance_v2(xStart, yStart, toPositive, onlyFullsolid)
{			
	// Set adjustable coordinates
	var X = xStart;
	var Y = yStart;
	var maxDistance = Grounded * (TileSize * 2)
	
	// Find distance downwards
	if toPositive
	{
		while !tile_meeting(X, Y, Layer) and Y < yStart + maxDistance
		{
			Y++;
		}
		while tile_meeting(X, Y, Layer)
		{
			Y--;
		}
		return Y - yStart;
	}
	
	// Find distance upwards
	else
	{
		while !tile_meeting(X, Y, Layer) and Y > yStart - maxDistance
		{
			Y--;
		}
		while tile_meeting(X, Y, Layer)
		{
			Y++;
		}
		return yStart - Y;
	}
}