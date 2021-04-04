function PlayerUpdateAngle()
{
	// Do not collide if we're not allowed to, or if we're standing on object
	if (AllowCollision == false or OnObject) exit;
	
	// Collide with one of four floor sides based on floor angle range
	switch AngleRange
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
			
			// Use closest distance for our calculations
			if dLeft <= dRight
			{
				var floorAngle = tile_get_angle_v(xLeft, yLeft, true, false, Layer);
			}
			else
			{
				var floorAngle = tile_get_angle_v(xRight, yRight, true, false, Layer);
			}
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
			
			// Use closest distance for our calculations
			if dLeft <= dRight
			{
				var floorAngle = tile_get_angle_h(xLeft, yLeft, true, false, Layer);
			}
			else
			{
				var floorAngle = tile_get_angle_h(xRight, yRight, true, false, Layer);
			}
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
			
			// Use closest distance for our calculations
			if dLeft <= dRight
			{
				var floorAngle	  = tile_get_angle_v(xLeft, yLeft, false, false, Layer);
			}
			else
			{
				var floorAngle    = tile_get_angle_v(xRight, yRight, false, false, Layer);
			}
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
			
			// Use closest distance for our calculations
			if dLeft <= dRight
			{
				var floorAngle    = tile_get_angle_h(xLeft, yLeft, false, false, Layer);
			}
			else
			{
				var floorAngle    = tile_get_angle_h(xRight, yRight, false, false, Layer);
			}
		}
		break;
	}
	
	// Use cardinal floor angle if difference is greater than 45
	if Game.ConsiderAngleDifference
	{
		var angDifference = abs(Angle - floorAngle);
		if  angDifference < 180
		{
			Angle = angDifference > 45  ? AngleRange * 90 : floorAngle;
		}
		else
		{
			Angle = angDifference < 315 ? AngleRange * 90 : floorAngle;
		}
		if (Angle = 0) Angle = 360;
	}
		
	// Use normal floor angle
	else
	{
		Angle = floorAngle;
	}
}