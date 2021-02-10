function PlayerAnglePosition()
{	
	/* While originals don't actually use floor angle to decide collision angle range and utilize
	regular angle value instead, we do this to improve stability and fix few flaws original games had */
	
	// Do not collide with floor when on object
	if OnObject exit;
	
	// Use player's movement angle to set coordinates and get floor distances
	switch round(Angle/90) % 4
	{
		case RangeFloor:
		{	
			var xLeft  = PosX - xRadius;
			var yLeft  = PosY + yRadius;
			var xRight = PosX + xRadius;
			var yRight = PosY + yRadius;
			
			var dLeft  = tile_get_distance_v(xLeft, yLeft, Layer, true, false);			
			var dRight = tile_get_distance_v(xRight, yRight, Layer, true, false);
		}
		break;
		case RangeRWall:
		{	
			var xLeft  = PosX + yRadius;
			var yLeft  = PosY + xRadius;
			var xRight = PosX + yRadius;
			var yRight = PosY - xRadius;
			
			var dLeft  = tile_get_distance_h(xLeft, yLeft, Layer, true, false);
			var dRight = tile_get_distance_h(xRight, yRight, Layer, true, false);
		}
		break;
		case RangeRoof:
		{	
			var xLeft  = PosX + xRadius;
			var yLeft  = PosY - yRadius;
			var xRight = PosX - xRadius;
			var yRight = PosY - yRadius;

			var dLeft  = tile_get_distance_v(xLeft, yLeft, Layer, false, false);
			var dRight = tile_get_distance_v(xRight, yRight, Layer, false, false);
		}
		break;
		case RangeLWall:
		{	
			var xLeft  = PosX - yRadius;
			var yLeft  = PosY - xRadius;
			var xRight = PosX - yRadius;
			var yRight = PosY + xRadius;
			
			var dLeft  = tile_get_distance_h(xLeft, yLeft, Layer, false, false);
			var dRight = tile_get_distance_h(xRight, yRight, Layer, false, false);
		}
		break;
	}
	
	// Get floor angle using closest distance
	FloorAngle = tile_get_angle(dLeft <= dRight ? xLeft : xRight, dLeft <= dRight ? yLeft : yRight, Layer);
}