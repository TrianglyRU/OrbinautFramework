function colmask_get_distance_h(xStart, yStart, toPositive, maxDistance)
{	
	// Set adjustable coordinates
	var X = xStart;
	var Y = yStart;
	
	// Find distance to the right
	if toPositive
	{
		while !colmask_meeting(X, Y, false) and X < xStart + maxDistance
		{
			X++;
		}
		while colmask_meeting(X, Y, false)
		{
			X--;
		}
		return X - xStart;
	}
	
	// Find distance to the left
	else
	{
		while !colmask_meeting(X, Y, false) and X > xStart - maxDistance
		{
			X--;
		}
		while colmask_meeting(X, Y, false)
		{
			X++;
		}
		return xStart - X;
	}
}