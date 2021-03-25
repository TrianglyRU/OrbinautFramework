function PlayerHitRoof()
{	
	// Do not collide if we're not allowed to
	if (Ysp < 0 or abs(Xsp) > abs(Ysp)) and AllowCollision
	{
		// Set coordinates
		var xLeft  = floor(PosX - xRadius);
		var yLeft  = floor(PosY - yRadius);
		var xRight = floor(PosX + xRadius);
		var yRight = floor(PosY - yRadius);
			
		// Get roof distances
		var dLeft  = tile_get_distance_v(xLeft, yLeft, false, true, Layer);
		var dRight = tile_get_distance_v(xRight, yRight, false, true, Layer);
		
		// Collide using closest distance
		var Distance = dLeft <= dRight? dLeft : dRight;
		if  Distance < 0
		{		
			// Collide 
			PosY -= Distance;
			
			// If moving upwards and not flying, check roof angle
			if abs(Ysp) > abs(Xsp) and FlyingState = false
			{	
				// Get roof angle
				if dLeft <= dRight
				{
					var roofAngle = tile_get_angle_v(xLeft, yLeft, false, true, Layer); 
				}
				else
				{
					var roofAngle = tile_get_angle_v(xRight, yRight, false, true, Layer);
				}

				// Land on the roof if it is steep enough
				if roofAngle > 90 and roofAngle < 135 or roofAngle > 225 and roofAngle < 270
				{	
					Grounded = true;
					Angle    = roofAngle;
					Inertia  = roofAngle < 180 ? -Ysp : Ysp;					
				} 
				else 
				{
					Ysp = 0;
				}
			}
			
			// else just reset our vertical speed
			else
			{	
				if (Ysp < 0) Ysp = 0;
			}
		}
	}
}