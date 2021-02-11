function PlayerCollideFloor()
{	
	// Do not collide with floor when on object
	if OnObject exit;

	// Collide with one of four floor sides based on current player's angle range
	switch AngleRange
	{
		case RangeFloor:
		{	
			// Set coordinates
			var xLeft  = floor(PosX) - xRadius;
			var yLeft  = floor(PosY) + yRadius;
			var xRight = floor(PosX) + xRadius;
			var yRight = floor(PosY) + yRadius;
			
			// Get floor distances
			var dLeft  = tile_get_distance_v(xLeft, yLeft, Layer, true, false);			
			var dRight = tile_get_distance_v(xRight, yRight, Layer, true, false);
			
			// Calculate collision tolerance
			CollisionDistance = Game.SpeedFloorClip ? min(4 + abs(floor(Xsp)), 14) : 14;
			
			// Collide using closest distance and update player's angle
			var Distance = dLeft <= dRight ? dLeft : dRight;
			if  Distance > CollisionDistance
			{
				Grounded = false;
			}
			else
			{
				PosY      += Distance;
				AngleRange = round(tile_get_angle(dLeft <= dRight ? xLeft : xRight, dLeft <= dRight ? yLeft : yRight, Layer)/90) % 4;
			}
		}
		break;
		case RangeRWall:
		{	
			// Set coordinates
			var xLeft  = floor(PosX) + yRadius;
			var yLeft  = floor(PosY) + xRadius;
			var xRight = floor(PosX) + yRadius;
			var yRight = floor(PosY) - xRadius;
			
			// Get floor distances
			var dLeft  = tile_get_distance_h(xLeft, yLeft, Layer, true, false);
			var dRight = tile_get_distance_h(xRight, yRight, Layer, true, false);
			
			// Calculate collision tolerance
			CollisionDistance = Game.SpeedFloorClip ? min(4 + abs(floor(Ysp)), 14) : 14;

			// Collide using closest distance and update player's angle
			var Distance = dLeft <= dRight ? dLeft : dRight;
			if  Distance > CollisionDistance
			{
				Grounded = false;
			}
			else
			{
				PosX	  += Distance;
				AngleRange = round(tile_get_angle(dLeft <= dRight ? xLeft : xRight, dLeft <= dRight ? yLeft : yRight, Layer)/90) % 4;
			}
		}
		break;
		case RangeRoof:
		{	
			// Set coordinates
			var xLeft  = floor(PosX) + xRadius;
			var yLeft  = floor(PosY) - yRadius;
			var xRight = floor(PosX) - xRadius;
			var yRight = floor(PosY) - yRadius;
			
			// Get floor distances
			var dLeft  = tile_get_distance_v(xLeft, yLeft, Layer, false, false);
			var dRight = tile_get_distance_v(xRight, yRight, Layer, false, false);

			// Calculate collision tolerance
			CollisionDistance = Game.SpeedFloorClip ? min(4 + abs(floor(Xsp)), 14) : 14;
			
			// Collide using closest distance and update player's angle
			var Distance = dLeft <= dRight ? dLeft : dRight;
			if  Distance > CollisionDistance
			{
				Grounded = false;
			}
			else
			{
				PosY	  -= Distance;
				AngleRange = round(tile_get_angle(dLeft <= dRight ? xLeft : xRight, dLeft <= dRight ? yLeft : yRight, Layer)/90) % 4;
			}
		}
		break;
		case RangeLWall:
		{	
			// Set coordinates
			var xLeft  = floor(PosX) - yRadius;
			var yLeft  = floor(PosY) - xRadius;
			var xRight = floor(PosX) - yRadius;
			var yRight = floor(PosY) + xRadius;
			 
			// Get floor distances and angles
			var dLeft  = tile_get_distance_h(xLeft, yLeft, Layer, false, false);
			var dRight = tile_get_distance_h(xRight, yRight, Layer, false, false);
			
			// Calculate collision tolerance
			CollisionDistance = Game.SpeedFloorClip ? min(4 + abs(floor(Ysp)), 14) : 14;

			// Collide using closest distance and update player's angle
			var Distance = dLeft <= dRight ? dLeft : dRight;
			if  Distance > CollisionDistance
			{
				Grounded = false;
			}
			else
			{
				PosX	  -= Distance;
				AngleRange = round(tile_get_angle(dLeft <= dRight ? xLeft : xRight, dLeft <= dRight ? yLeft : yRight, Layer)/90) % 4;
			}
		}
		break;
	}
}