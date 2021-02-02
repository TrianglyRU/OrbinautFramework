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
			var dLeft  = colmask_get_distance_v(xLeft, yLeft, true, false);			
			var dRight = colmask_get_distance_v(xRight, yRight, true, false);
			
			show_debug_message(tile_get_distance_v(xLeft, yLeft, Layer, true, false));
			show_debug_message(tile_get_distance_v(xRight, yRight, Layer, true, false));
			
			// Get the closest distance and floor angle
			if dLeft <= dRight
			{
				var Distance   = dLeft;
				var FloorAngle = colmask_get_angle_v(xLeft, yLeft, true);
			}
			else
			{
				var Distance   = dRight;
				var FloorAngle = colmask_get_angle_v(xRight, yRight, true);
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
			var dLeft  = colmask_get_distance_h(xLeft, yLeft, true, false)
			var dRight = colmask_get_distance_h(xRight, yRight, true, false)

			// Get the closest distance and floor angle
			if dLeft <= dRight
			{
				var Distance   = dLeft;
				var FloorAngle = colmask_get_angle_h(xLeft, yLeft, true);
			}
			else
			{
				var Distance   = dRight;
				var FloorAngle = colmask_get_angle_h(xRight, yRight, true);
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
			var dLeft  = colmask_get_distance_v(xLeft, yLeft, false, false)
			var dRight = colmask_get_distance_v(xRight, yRight, false, false)
			
			//show_debug_message(tile_get_distance_v(xLeft, yLeft, Layer, false, false));
			
			// Get the closest distance and floor angle
			if dLeft <= dRight
			{
				var Distance   = dLeft;
				var FloorAngle = colmask_get_angle_v(xLeft, yLeft, false);
			}
			else
			{
				var Distance   = dRight;
				var FloorAngle = colmask_get_angle_v(xRight, yRight, false);
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
			var dLeft  = colmask_get_distance_h(xLeft, yLeft, false, false)
			var dRight = colmask_get_distance_h(xRight, yRight, false, false)
			
			// Get the closest distance and floor angle
			if dLeft <= dRight
			{
				var Distance   = dLeft;
				var FloorAngle = colmask_get_angle_h(xLeft, yLeft, false);
			}
			else
			{
				var Distance   = dRight;
				var FloorAngle = colmask_get_angle_h(xRight, yRight, false);
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