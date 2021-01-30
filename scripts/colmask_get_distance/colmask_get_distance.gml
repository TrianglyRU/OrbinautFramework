// Function 1
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

// Function 2
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