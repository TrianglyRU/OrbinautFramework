function PlayerHitRoof()
{	
	// Do not collide if we're not allowed to
	if !AllowCollision exit;
	
	if Ysp < 0 or abs(Xsp) > abs(Ysp)
	{
		// Set coordinates
		var xLeft  = floor(PosX - xRadius);
		var yLeft  = floor(PosY - yRadius);
		var xRight = floor(PosX + xRadius);
		var yRight = floor(PosY - yRadius);
			
		// Get roof distances
		var dLeft  = tile_get_data_v(xLeft, yLeft, Layer, false, "data_distance", true);
		var dRight = tile_get_data_v(xRight, yRight, Layer, false, "data_distance", true);
		
		// Collide using closest distance
		var Distance = dLeft <= dRight? dLeft : dRight;
		if  Distance < 0
		{		
			// Collide 
			PosY -= Distance;
			
			// If moving upwards, check roof angle
			if abs(Ysp) > abs(Xsp)
			{	
				// Get roof angle
				var roofAngle = dLeft <= dRight ? tile_get_data_v(xLeft, yLeft, Layer, false, "data_angle", true) 
											    : tile_get_data_v(xRight, yRight, Layer, false, "data_angle", true);

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