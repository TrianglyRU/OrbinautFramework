function PlayerCollideFloor()
{	
	// Do not collide if we're not allowed to, or if we're standing on object
	if !AllowCollision or OnObject exit;

	// Collide with one of four floor sides based on floor angle range
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
			var dLeft  = tile_get_data_v(xLeft, yLeft, Layer, true, "data_distance", false);
			var dRight = tile_get_data_v(xRight, yRight, Layer, true, "data_distance", false);

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
			var dLeft  = tile_get_data_h(xLeft, yLeft, Layer, true, "data_distance", false);
			var dRight = tile_get_data_h(xRight, yRight, Layer, true, "data_distance", false);
			
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
			var dLeft  = tile_get_data_v(xLeft, yLeft, Layer, false, "data_distance", false);
			var dRight = tile_get_data_v(xRight, yRight, Layer, false, "data_distance", false);

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
			var dLeft  = tile_get_data_h(xLeft, yLeft, Layer, false, "data_distance", false);
			var dRight = tile_get_data_h(xRight, yRight, Layer, false, "data_distance", false);
			
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