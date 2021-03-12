function PlayerUpdateAngle()
{	
	// Reset angle if we're standing on object
	if (OnObject) Angle = 0;
	
	// Else update angle using closest floor distance
	else
	{
		switch round(Angle/90) % 4
		{
			case RangeFloor:
			{	
				// Get player collision points
				var xLeft  = floor(PosX - xRadius);
				var yLeft  = floor(PosY + yRadius);
				var xRight = floor(PosX + xRadius);
				var yRight = floor(PosY + yRadius);

				// Get floor distances
				var dLeft  = tile_get_distance_v(xLeft, yLeft, true, false, Layer);
				var dRight = tile_get_distance_v(xRight, yRight, true, false, Layer);
				
				// Use closest distacne in our calculations
				if dLeft <= dRight
				{
					var angX = xLeft;
					var angY = yLeft;
				}
				else
				{
					var angX = xRight;
					var angY = yRight;
				}
				
				// Get floor angle
				var floorAngle = tile_get_angle_v(angX, angY, true, false, Layer);
			}
			break;
			case RangeRWall:
			{	
				// Get player collision points
				var xLeft  = floor(PosX + yRadius);
				var yLeft  = floor(PosY + xRadius);
				var xRight = floor(PosX + yRadius);
				var yRight = floor(PosY - xRadius);
			
				// Get floor distances
				var dLeft  = tile_get_distance_h(xLeft, yLeft, true, false, Layer);
				var dRight = tile_get_distance_h(xRight, yRight, true, false, Layer);
				
				// Use closest distacne in our calculations
				if dLeft <= dRight
				{
					var angX = xLeft;
					var angY = yLeft;
				}
				else
				{
					var angX = xRight;
					var angY = yRight;
				}
				
				// Get floor angle
				var floorAngle = tile_get_angle_h(angX, angY, true, false, Layer);
			}
			break;
			case RangeRoof:
			{	
				// Get player collision points
				var xLeft  = floor(PosX + xRadius);
				var yLeft  = floor(PosY - yRadius);
				var xRight = floor(PosX - xRadius);
				var yRight = floor(PosY - yRadius);
				
				// Get floor distances
				var dLeft  = tile_get_distance_v(xLeft, yLeft, false, false, Layer);
				var dRight = tile_get_distance_v(xRight, yRight, false, false, Layer);
				
				// Use closest distacne in our calculations
				if dLeft <= dRight
				{
					var angX = xLeft;
					var angY = yLeft;
				}
				else
				{
					var angX = xRight;
					var angY = yRight;
				}
				
				// Get floor angle
				var floorAngle = tile_get_angle_v(angX, angY, false, false, Layer);
			}
			break;
			case RangeLWall:
			{	
				// Get player collision points
				var xLeft  = floor(PosX - yRadius);
				var yLeft  = floor(PosY - xRadius);
				var xRight = floor(PosX - yRadius);
				var yRight = floor(PosY + xRadius);
				
				// Get floor distances
				var dLeft  = tile_get_distance_h(xLeft, yLeft, false, false, Layer);
				var dRight = tile_get_distance_h(xRight, yRight, false, false, Layer);
				
				// Use closest distacne in our calculations
				if dLeft <= dRight
				{
					var angX = xLeft;
					var angY = yLeft;
				}
				else
				{
					var angX = xRight;
					var angY = yRight;
				}
				
				// Get floor angle
				var floorAngle = tile_get_angle_h(angX, angY, false, false, Layer);
			}
			break;
		}
		
		// Use cardinal floor angle if difference is greater than 45
		var angDifference = abs(Angle - floorAngle);
		if  angDifference < 180
		{
			Angle = angDifference > 45  ? (round(Angle/90) % 4) * 90 : floorAngle;
		}
		else
		{
			Angle = angDifference < 315 ? (round(Angle/90) % 4) * 90 : floorAngle;
		}
	}
}