function PlayerAnglePosition()
{
	// Get floor angle
	switch round(Angle/90) % 4
	{
		case PositionFloor:
		{	
			// Set coordinates
			var xLeft  = floor(PosX - xRadius);
			var yLeft  = floor(PosY + yRadius);
			var xRight = floor(PosX + xRadius);
			var yRight = floor(PosY + yRadius);
			
			// Get floor distances
			var dLeft  = colmask_get_distance_v(xLeft, yLeft, true, TileSize)
			var dRight = colmask_get_distance_v(xRight, yRight, true, TileSize)

			// Define distance and angle to use
			if dLeft <= dRight
			{
				var FloorAngle = colmask_get_angle_v(xLeft, yLeft, true);
			}
			else
			{
				var FloorAngle = colmask_get_angle_v(xRight, yRight, true);
			}
		}
		break;
		case PositionRightwall:
		{	
			// Set coordinates
			var xLeft  = floor(PosX + yRadius);
			var yLeft  = floor(PosY + xRadius);
			var xRight = floor(PosX + yRadius);
			var yRight = floor(PosY - xRadius);
			
			// Get floor distances
			var dLeft  = colmask_get_distance_h(xLeft, yLeft, true, TileSize)
			var dRight = colmask_get_distance_h(xRight, yRight, true, TileSize)

			// Define distance and angle to use
			if dLeft <= dRight
			{
				var FloorAngle = colmask_get_angle_h(xLeft, yLeft, true);
			}
			else
			{
				var FloorAngle = colmask_get_angle_h(xRight, yRight, true);
			}
		}
		break;
		case PositionRoof:
		{	
			// Set coordinates
			var xLeft  = floor(PosX + xRadius);
			var yLeft  = floor(PosY - yRadius);
			var xRight = floor(PosX - xRadius);
			var yRight = floor(PosY - yRadius);
			
			// Get floor distances and angles
			var dLeft  = colmask_get_distance_v(xLeft, yLeft, false, TileSize)
			var dRight = colmask_get_distance_v(xRight, yRight, false, TileSize)
			
			// Define distance and angle to use
			if dLeft <= dRight
			{
				var FloorAngle = colmask_get_angle_v(xLeft, yLeft, false);
			}
			else
			{
				var FloorAngle = colmask_get_angle_v(xRight, yRight, false);
			}
		}
		break;
		case PositionLeftwall:
		{	
			// Set coordinates
			var xLeft  = floor(PosX - yRadius);
			var yLeft  = floor(PosY - xRadius);
			var xRight = floor(PosX - yRadius);
			var yRight = floor(PosY + xRadius);
			
			// Get floor distances and angles
			var dLeft  = colmask_get_distance_h(xLeft, yLeft, false, TileSize)
			var dRight = colmask_get_distance_h(xRight, yRight, false, TileSize)
			
			// Define distance and angle to use
			if dLeft <= dRight
			{
				var FloorAngle = colmask_get_angle_h(xLeft, yLeft, false);
			}
			else
			{
				var FloorAngle = colmask_get_angle_h(xRight, yRight, false);
			}
		}
		break;
	}
	
	// Set angle position
	AnglePosition = round(FloorAngle/90) % 4;
}