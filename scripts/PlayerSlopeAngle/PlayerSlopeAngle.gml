function PlayerSlopeAngle()
{	
	// Get floor angle
	if !OnObject
	{
		switch AngleRange
		{
			case RangeFloor:
			{	
				var xLeft  = floor(PosX) - xRadius;
				var yLeft  = floor(PosY) + yRadius;
				var xRight = floor(PosX) + xRadius;
				var yRight = floor(PosY) + yRadius;
			
				var dLeft  = tile_get_distance_v(xLeft, yLeft, Layer, true, false);			
				var dRight = tile_get_distance_v(xRight, yRight, Layer, true, false);
			}
			break;
			case RangeRWall:
			{	
				var xLeft  = floor(PosX) + yRadius;
				var yLeft  = floor(PosY) + xRadius;
				var xRight = floor(PosX) + yRadius;
				var yRight = floor(PosY) - xRadius;
			
				var dLeft  = tile_get_distance_h(xLeft, yLeft, Layer, true, false);
				var dRight = tile_get_distance_h(xRight, yRight, Layer, true, false);
			}
			break;
			case RangeRoof:
			{	
				var xLeft  = floor(PosX) + xRadius;
				var yLeft  = floor(PosY) - yRadius;
				var xRight = floor(PosX) - xRadius;
				var yRight = floor(PosY) - yRadius;

				var dLeft  = tile_get_distance_v(xLeft, yLeft, Layer, false, false);
				var dRight = tile_get_distance_v(xRight, yRight, Layer, false, false);
			}
			break;
			case RangeLWall:
			{	
				var xLeft  = floor(PosX) - yRadius;
				var yLeft  = floor(PosY) - xRadius;
				var xRight = floor(PosX) - yRadius;
				var yRight = floor(PosY) + xRadius;
			
				var dLeft  = tile_get_distance_h(xLeft, yLeft, Layer, false, false);
				var dRight = tile_get_distance_h(xRight, yRight, Layer, false, false);
			}
			break;
		}
		Angle = tile_get_angle(dLeft <= dRight ? xLeft : xRight, dLeft <= dRight ? yLeft : yRight, Layer);
	}
	
	// Set angle to 0 if we're on the object
	else
	{
		Angle = 0;
	}
}