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

			// Collide using closest distance
			var maxDistance = Game.SpeedFloorClip ? min(4 + abs(floor(Xsp)), 14) : 14;
			var Distance    = dLeft <= dRight ? dLeft : dRight;	
			
			if  Distance > maxDistance
			{
				Grounded = false;
			}
			else if Distance > -14
			{
				PosY += Distance;
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
			
			// Collide using closest distance
			var maxDistance = Game.SpeedFloorClip ? min(4 + abs(floor(Ysp)), 14) : 14;
			var Distance    = dLeft <= dRight ? dLeft : dRight;
			
			if  Distance > maxDistance
			{
				Grounded = false;
			}
			else if Distance > -14
			{
				PosX += Distance;
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

			// Collide using closest distance
			var maxDistance = Game.SpeedFloorClip ? min(4 + abs(floor(Xsp)), 14) : 14;
			var Distance    = dLeft <= dRight ? dLeft : dRight;
			
			if  Distance > maxDistance
			{
				Grounded = false;
			}
			else if Distance > -14
			{
				PosY -= Distance;
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
			
			// Collide using closest distance
			var maxDistance = Game.SpeedFloorClip ? min(4 + abs(floor(Ysp)), 14) : 14;
			var Distance    = dLeft <= dRight ? dLeft : dRight;
			
			if  Distance > maxDistance
			{
				Grounded = false;
			}
			else if Distance > -14
			{
				PosX -= Distance;
			}
		}
		break;
	}
}