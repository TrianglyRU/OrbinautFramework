function colmask_get_distance_v(xStart, yStart, toPositive, maxDistance)
{
	// Set adjustable coordinates
	var X = xStart;
	var Y = yStart;
	
	// Find distance downwards
	if toPositive
	{
		while !colmask_meeting(X, Y, false) and Y < yStart + maxDistance
		{
			Y++;
		}
		while colmask_meeting(X, Y, false)
		{
			Y--;
		}
		return Y - yStart;
	}
	
	// Find distance upwards
	else
	{
		while !colmask_meeting(X, Y, false) and Y > yStart - maxDistance
		{
			Y--;
		}
		while colmask_meeting(X, Y, false)
		{
			Y++;
		}
		return yStart - Y;
	}
}