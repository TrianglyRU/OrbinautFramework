function PlayerUpdateAngle()
{	
	// Reset angle if we're standing on object
	if OnObject
	{
		Angle = 0;
	}
	
	// Else update angle using closest floor distance
	else
	{
		switch round(Angle/90) % 4
		{
			case RangeFloor:
			{	
				var xLeft  = floor(PosX - xRadius);
				var yLeft  = floor(PosY + yRadius);
				var xRight = floor(PosX + xRadius);
				var yRight = floor(PosY + yRadius);

				var dLeft  = tile_get_data_v(xLeft,  yLeft,  Layer, true, 0);
				var dRight = tile_get_data_v(xRight, yRight, Layer, true, 0);
				var fAngle = tile_get_data_v(dLeft <= dRight ? xLeft : xRight, dLeft <= dRight ? yLeft : yRight, Layer, true, 1);
			}
			break;
			case RangeRWall:
			{	
				var xLeft  = floor(PosX + yRadius);
				var yLeft  = floor(PosY + xRadius);
				var xRight = floor(PosX + yRadius);
				var yRight = floor(PosY - xRadius);
			
				var dLeft  = tile_get_data_h(xLeft,  yLeft,  Layer, true, 0);
				var dRight = tile_get_data_h(xRight, yRight, Layer, true, 0);
				var fAngle = tile_get_data_h(dLeft <= dRight ? xLeft : xRight, dLeft <= dRight ? yLeft : yRight, Layer, true, 1);
			}
			break;
			case RangeRoof:
			{	
				var xLeft  = floor(PosX + xRadius);
				var yLeft  = floor(PosY - yRadius);
				var xRight = floor(PosX - xRadius);
				var yRight = floor(PosY - yRadius);
			
				var dLeft  = tile_get_data_v(xLeft,  yLeft,  Layer, false, 0);
				var dRight = tile_get_data_v(xRight, yRight, Layer, false, 0);
				var fAngle = tile_get_data_v(dLeft <= dRight ? xLeft : xRight, dLeft <= dRight ? yLeft : yRight, Layer, false, 1);
			}
			break;
			case RangeLWall:
			{	
				var xLeft  = floor(PosX - yRadius);
				var yLeft  = floor(PosY - xRadius);
				var xRight = floor(PosX - yRadius);
				var yRight = floor(PosY + xRadius);
			 
				var dLeft  = tile_get_data_h(xLeft,  yLeft,  Layer, false, 0);
				var dRight = tile_get_data_h(xRight, yRight, Layer, false, 0);
				var fAngle = tile_get_data_h(dLeft <= dRight ? xLeft : xRight, dLeft <= dRight ? yLeft : yRight, Layer, false, 1);
			}
			break;
		}
		// Use cardinal floor angle if angle difference is greater than 45
		var angDifference = abs(Angle - fAngle);
		if  angDifference < 180
		{
			Angle = angDifference > 45 ? round(Angle/90) % 4 * 90 : fAngle;
		}
		else
		{
			Angle = angDifference < 315 ? round(Angle/90) % 4 * 90 : fAngle;
		}
	}
}