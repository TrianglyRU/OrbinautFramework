function PlayerCollideFloor()
{	
	// Do not collide with floor when on object
	if OnObject exit;

	// Collide with one of four floor sides based on current angle range
	switch round(Angle/90) % 4
	{
		case RangeFloor:
		{	
			// Set coordinates
			var xLeft  = floor(PosX - xRadius);
			var yLeft  = floor(PosY + yRadius);
			var xRight = floor(PosX + xRadius);
			var yRight = floor(PosY + yRadius);
			
			// Get floor distances
			if !Game.TileCollisionMethod
			{
				var dLeft  = colmask_get_distance_v(xLeft, yLeft, true, false);			
				var dRight = colmask_get_distance_v(xRight, yRight, true, false);
			}
			else
			{
				var dLeft  = tile_get_distance_v(xLeft, yLeft, Layer, true, false);			
				var dRight = tile_get_distance_v(xRight, yRight, Layer, true, false);
			}
			
			// Get the closest distance
			var Distance = dLeft <= dRight ? dLeft : dRight;
			
			// Get floor angle
			if !Game.TileCollisionMethod
			{
				if dLeft <= dRight
				{
					var FloorAngle = colmask_get_angle_v(xLeft, yLeft, true);
				}
				else
				{
					var FloorAngle = colmask_get_angle_v(xRight, yRight, true);
				}
			}
			else
			{
				if dLeft <= dRight
				{
					var FloorAngle = tile_get_angle(xLeft, yLeft, Layer);
				}
				else
				{
					var FloorAngle = tile_get_angle(xRight, yRight, Layer);
				}
			}
			
			// Update player's angle, use cardinal one if the difference is higher than 45
			if Game.ConsiderAngleDifference
			{
				var Difference = abs(Angle - FloorAngle);
				if  Difference < 180
				{
					Angle = Difference > 45 ? 0 : FloorAngle;
				}
				else
				{
					Angle = Difference < 315 ? 0 : FloorAngle;
				}
			}
			
			// Calculate collision tolerance
			CollisionDistance = Game.SpeedFloorClip ? min(4 + abs(floor(Xsp)), 14) : 14;
			
			// Collide
			if Distance > CollisionDistance
			{
				Grounded = false;
			}
			else //if Distance > -14
			{
				PosY += Distance;
			}
		}
		break;
		case RangeRWall:
		{	
			// Set coordinates
			var xLeft  = floor(PosX + yRadius);
			var yLeft  = floor(PosY + xRadius);
			var xRight = floor(PosX + yRadius);
			var yRight = floor(PosY - xRadius);
			
			// Get floor distances
			if !Game.TileCollisionMethod
			{
				var dLeft  = colmask_get_distance_h(xLeft, yLeft, true, false);
				var dRight = colmask_get_distance_h(xRight, yRight, true, false);
			}
			else
			{
				var dLeft  = tile_get_distance_h(xLeft, yLeft, Layer, true, false);
				var dRight = tile_get_distance_h(xRight, yRight, Layer, true, false);
			}
				
			// Get the closest distance
			var Distance = dLeft <= dRight ? dLeft : dRight;

			// Get floor angle
			if !Game.TileCollisionMethod
			{
				if dLeft <= dRight
				{
					var FloorAngle = colmask_get_angle_h(xLeft, yLeft, true);
				}
				else
				{
					var FloorAngle = colmask_get_angle_h(xRight, yRight, true);
				}
			}
			else
			{
				if dLeft <= dRight
				{
					var FloorAngle = tile_get_angle(xLeft, yLeft, Layer);
				}
				else
				{
					var FloorAngle = tile_get_angle(xRight, yRight, Layer);
				}
			}
			
			// Update player's angle, use cardinal one if the difference is higher than 45
			if Game.ConsiderAngleDifference
			{
				var Difference = abs(Angle - FloorAngle);
				if  Difference < 180
				{
					Angle = Difference > 45 ? 90 : FloorAngle;
				}
				else
				{
					Angle = Difference < 315 ? 90 : FloorAngle;
				}
			}
			
			// Calculate collision tolerance
			CollisionDistance = Game.SpeedFloorClip ? min(4 + abs(floor(Ysp)), 14) : 14;

			// Collide
			if Distance > CollisionDistance
			{
				Grounded = false;
			}
			else //if Distance > -14
			{
				PosX += Distance;;
			}
		}
		break;
		case RangeRoof:
		{	
			// Set coordinates
			var xLeft  = floor(PosX + xRadius);
			var yLeft  = floor(PosY - yRadius);
			var xRight = floor(PosX - xRadius);
			var yRight = floor(PosY - yRadius);
			
			// Get floor distances
			if !Game.TileCollisionMethod
			{
				var dLeft  = colmask_get_distance_v(xLeft, yLeft, false, false);
				var dRight = colmask_get_distance_v(xRight, yRight, false, false);
			}
			else
			{
				var dLeft  = tile_get_distance_v(xLeft, yLeft, Layer, false, false);
				var dRight = tile_get_distance_v(xRight, yRight, Layer, false, false);
			}
			
			// Get the closest distance
			var Distance = dLeft <= dRight ? dLeft : dRight;
			
			// Get floor angle
			if !Game. TileCollisionMethod
			{
				if dLeft <= dRight
				{
					var FloorAngle = colmask_get_angle_v(xLeft, yLeft, false);
				}
				else
				{
					var FloorAngle = colmask_get_angle_v(xRight, yRight, false);
				}
			}
			else
			{
				if dLeft <= dRight
				{
					var FloorAngle = tile_get_angle(xLeft, yLeft, Layer);
				}
				else
				{
					var FloorAngle = tile_get_angle(xRight, yRight, Layer);
				}
			}
			
			// Update player's angle, use cardinal one if the difference is higher than 45
			if Game.ConsiderAngleDifference
			{
				var Difference = abs(Angle - FloorAngle);
				if  Difference < 180
				{
					Angle = Difference > 45 ? 180 : FloorAngle;
				}
				else
				{
					Angle = Difference < 315 ? 180 : FloorAngle;
				}
			}
			
			// Calculate collision tolerance
			CollisionDistance = Game.SpeedFloorClip ? min(4 + abs(floor(Xsp)), 14) : 14;
			
			// Collide
			if Distance > CollisionDistance
			{
				Grounded = false;
			}
			else //if Distance > -14
			{
				PosY -= Distance;
			}
		}
		break;
		case RangeLWall:
		{	
			// Set coordinates
			var xLeft  = floor(PosX - yRadius);
			var yLeft  = floor(PosY - xRadius);
			var xRight = floor(PosX - yRadius);
			var yRight = floor(PosY + xRadius);
			
			// Get floor distances and angles
			if !Game.TileCollisionMethod
			{
				var dLeft  = colmask_get_distance_h(xLeft, yLeft, false, false);
				var dRight = colmask_get_distance_h(xRight, yRight, false, false);
			}
			else
			{
				var dLeft  = tile_get_distance_h(xLeft, yLeft, Layer, false, false);
				var dRight = tile_get_distance_h(xRight, yRight, Layer, false, false);
			}
			
			// Get the closest distance
			var Distance = dLeft <= dRight ? dLeft : dRight;
			
			// Get the closest distance and floor angle
			if !Game.TileCollisionMethod
			{
				if dLeft <= dRight
				{
					var FloorAngle = colmask_get_angle_h(xLeft, yLeft, false);
				}
				else
				{
					var FloorAngle = colmask_get_angle_h(xRight, yRight, false);
				}
			}
			else
			{
				if dLeft <= dRight
				{
					var FloorAngle = tile_get_angle(xLeft, yLeft, Layer);
				}
				else
				{
					var FloorAngle = tile_get_angle(xRight, yRight, Layer);
				}
			}
			
			// Update player's angle, use cardinal one if the difference is higher than 45
			if Game.ConsiderAngleDifference
			{
				var Difference = abs(Angle - FloorAngle);
				if  Difference < 180
				{
					Angle = Difference > 45 ? 270 : FloorAngle;
				}
				else
				{
					Angle = Difference < 315 ? 270 : FloorAngle;
				}
			}
			
			// Calculate collision tolerance
			CollisionDistance = Game.SpeedFloorClip ? min(4 + abs(floor(Ysp)), 14) : 14;

			// Collide
			if Distance > CollisionDistance
			{
				Grounded = false;
			}
			else //if Distance > -14
			{
				PosX -= Distance;
			}
		}
		break;
	}
}