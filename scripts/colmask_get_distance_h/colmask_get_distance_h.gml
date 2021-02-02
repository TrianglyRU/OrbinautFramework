/// @function colmask_get_distance_h(xStart, yStart, toPositive, onlyFullsolid)
function colmask_get_distance_h(xStart, yStart, toPositive, onlyFullsolid)
{	
	// Set adjustable coordinates
	var X = xStart;
	var Y = yStart;
	var maxDistance = Grounded * (TileSize * 2)
	
	// Find distance to the right
	if toPositive
	{
		while !colmask_meeting(X, Y, onlyFullsolid) and X < xStart + maxDistance
		{
			X++;
		}
		while colmask_meeting(X, Y, onlyFullsolid)
		{
			X--;
		}
		return X - xStart;
	}
	
	// Find distance to the left
	else
	{
		while !colmask_meeting(X, Y, onlyFullsolid) and X > xStart - maxDistance
		{
			X--;
		}
		while colmask_meeting(X, Y, onlyFullsolid)
		{
			X++;
		}
		return xStart - X;
	}
}