function PlayerCollideFloor()
{	
	// Do not collide with floor when on object
	if OnObject exit;

	// Collide with one of four floor sides based on current floor angle range
	switch round(FloorAngle/90) % 4
	{
		case RangeFloor:
		{	
			// Set coordinates
			var xLeft  = PosX - xRadius;
			var yLeft  = PosY + yRadius;
			var xRight = PosX + xRadius;
			var yRight = PosY + yRadius;
			
			// Get floor distances
			var dLeft  = tile_get_distance_v(xLeft, yLeft, Layer, true, false);			
			var dRight = tile_get_distance_v(xRight, yRight, Layer, true, false);
			
			// Calculate collision tolerance
			CollisionDistance = Game.SpeedFloorClip ? min(4 + abs(floor(Xsp)), 14) : 14;
			
			// Collide using closest distance and get movement angle
			var Distance = dLeft <= dRight ? dLeft : dRight;
			if  Distance > CollisionDistance
			{
				Grounded = false;
			}
			else
			{
				RealPosY += Distance;
				Angle = tile_get_angle(dLeft <= dRight ? xLeft : xRight, dLeft <= dRight ? yLeft : yRight, Layer);
			}
		}
		break;
		case RangeRWall:
		{	
			// Set coordinates
			var xLeft  = PosX + yRadius;
			var yLeft  = PosY + xRadius;
			var xRight = PosX + yRadius;
			var yRight = PosY - xRadius;
			
			// Get floor distances
			var dLeft  = tile_get_distance_h(xLeft, yLeft, Layer, true, false);
			var dRight = tile_get_distance_h(xRight, yRight, Layer, true, false);
			
			// Calculate collision tolerance
			CollisionDistance = Game.SpeedFloorClip ? min(4 + abs(floor(Ysp)), 14) : 14;

			// Collide using closest distance and get movement angle
			var Distance = dLeft <= dRight ? dLeft : dRight;
			if  Distance > CollisionDistance
			{
				Grounded = false;
			}
			else
			{
				RealPosX += Distance;
				Angle = tile_get_angle(dLeft <= dRight ? xLeft : xRight, dLeft <= dRight ? yLeft : yRight, Layer);
			}
		}
		break;
		case RangeRoof:
		{	
			// Set coordinates
			var xLeft  = PosX + xRadius;
			var yLeft  = PosY - yRadius;
			var xRight = PosX - xRadius;
			var yRight = PosY - yRadius;
			
			// Get floor distances
			var dLeft  = tile_get_distance_v(xLeft, yLeft, Layer, false, false);
			var dRight = tile_get_distance_v(xRight, yRight, Layer, false, false);

			// Calculate collision tolerance
			CollisionDistance = Game.SpeedFloorClip ? min(4 + abs(floor(Xsp)), 14) : 14;
			
			// Collide using closest distance and get movement angle
			var Distance = dLeft <= dRight ? dLeft : dRight;
			if  Distance > CollisionDistance
			{
				Grounded = false;
			}
			else
			{
				RealPosY -= Distance;
				Angle = tile_get_angle(dLeft <= dRight ? xLeft : xRight, dLeft <= dRight ? yLeft : yRight, Layer);
			}
		}
		break;
		case RangeLWall:
		{	
			// Set coordinates
			var xLeft  = PosX - yRadius;
			var yLeft  = PosY - xRadius;
			var xRight = PosX - yRadius;
			var yRight = PosY + xRadius;
			 
			// Get floor distances and angles
			var dLeft  = tile_get_distance_h(xLeft, yLeft, Layer, false, false);
			var dRight = tile_get_distance_h(xRight, yRight, Layer, false, false);
			
			// Calculate collision tolerance
			CollisionDistance = Game.SpeedFloorClip ? min(4 + abs(floor(Ysp)), 14) : 14;

			// Collide using closest distance and get movement angle
			var Distance = dLeft <= dRight ? dLeft : dRight;
			if  Distance > CollisionDistance
			{
				Grounded = false;
			}
			else
			{
				RealPosX -= Distance;
				Angle = tile_get_angle(dLeft <= dRight ? xLeft : xRight, dLeft <= dRight ? yLeft : yRight, Layer);
			}
		}
		break;
	}
}