function PlayerCollideFloor()
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
			
			// Get floor angles
			var aLeft  = tile_get_angle_v(xLeft, yLeft, true, false, Layer);
			var aRight = tile_get_angle_v(xRight, yRight, true, false, Layer);

			// Collide using closest distance
			var floorDistance = dLeft <= dRight ? dLeft : dRight;
			var floorAngle    = dLeft <= dRight ? aLeft : aRight;
			var maxDistance   = Game.SpeedFloorClip ? min(4 + abs(floor(Xsp)), 14) : 14;
			
			if floorDistance > maxDistance
			{
				Grounded = false;
			}
			else if floorDistance > -14
			{
				PosY += floorDistance;
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
			
			// Get floor angles
			var aLeft  = tile_get_angle_h(xLeft, yLeft, true, false, Layer);
			var aRight = tile_get_angle_h(xRight, yRight, true, false, Layer);
			
			// Collide using closest distance
			var floorDistance = dLeft <= dRight ? dLeft : dRight;
			var floorAngle    = dLeft <= dRight ? aLeft : aRight;
			var maxDistance   = Game.SpeedFloorClip ? min(4 + abs(floor(Ysp)), 14) : 14;
			
			if floorDistance > maxDistance
			{
				Grounded = false;
			}
			else if floorDistance > -14
			{
				PosX += floorDistance;
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
			
			// Get floor angles
			var aLeft  = tile_get_angle_v(xLeft, yLeft, false, false, Layer);
			var aRight = tile_get_angle_v(xRight, yRight, false, false, Layer);

			// Collide using closest distance
			var floorDistance = dLeft <= dRight ? dLeft : dRight;
			var floorAngle    = dLeft <= dRight ? aLeft : aRight;
			var maxDistance   = Game.SpeedFloorClip ? min(4 + abs(floor(Xsp)), 14) : 14;
			
			if floorDistance > maxDistance
			{
				Grounded = false;
			}
			else if floorDistance > -14
			{
				PosY -= floorDistance;
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
			
			// Get floor angles
			var aLeft  = tile_get_angle_h(xLeft, yLeft, false, false, Layer);
			var aRight = tile_get_angle_h(xRight, yRight, false, false, Layer);
			
			// Collide using closest distance
			var floorDistance = dLeft <= dRight ? dLeft : dRight;
			var floorAngle    = dLeft <= dRight ? aLeft : aRight;
			var maxDistance   = Game.SpeedFloorClip ? min(4 + abs(floor(Ysp)), 14) : 14;
			
			if floorDistance > maxDistance
			{
				Grounded = false;
			}
			else if floorDistance > -14
			{
				PosX -= floorDistance;
			}
		}
		break;
	}
	
	Game.Value[0] = floorAngle;
	Game.Value[1] = dLeft;
	Game.Value[2] = dRight;
	Game.Value[3] = dLeft <= dRight ? "LEFT" : "RIGHT";
	
	// Use cardinal floor angle if difference is greater than 45
	if Game.ConsiderAngleDifference
	{
		var angDifference = abs(Angle - floorAngle);
		if  angDifference < 180
		{
			Angle = angDifference > 45  ? (round(Angle/90) % 4) * 90 : floorAngle;
		}
		else
		{
			Angle = angDifference < 315 ? (round(Angle/90) % 4) * 90 : floorAngle;
		}
		if (Angle = 0) Angle = 360;
	}
		
	// Use normal floor angle
	else
	{
		Angle = floorAngle;
	}
}