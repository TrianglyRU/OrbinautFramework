/// @function colmask_get_distance_v(xStart, yStart, toPositive, onlyFullsolid)
function colmask_get_distance_v(xStart, yStart, toPositive, onlyFullsolid)
{			
	// Set adjustable coordinates
	var X = xStart;
	var Y = yStart;
	var maxDistance = Grounded * (TileSize * 2)
	
	// Find distance downwards
	if toPositive
	{
		while !colmask_meeting(X, Y, onlyFullsolid) and Y < yStart + maxDistance
		{
			Y++;
		}
		while colmask_meeting(X, Y, onlyFullsolid)
		{
			Y--;
		}
		return Y - yStart;
	}
	
	// Find distance upwards
	else
	{
		while !colmask_meeting(X, Y, onlyFullsolid) and Y > yStart - maxDistance
		{
			Y--;
		}
		while colmask_meeting(X, Y, onlyFullsolid)
		{
			Y++;
		}
		return yStart - Y;
	}
}