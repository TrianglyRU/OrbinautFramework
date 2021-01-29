function PlayerHitRoof()
{	
	if Ysp < 0 or abs(Xsp) > abs(Ysp)
	{
		// Set coordinates
		var xLeft  = floor(PosX - xRadius);
		var yLeft  = floor(PosY - yRadius);
		var xRight = floor(PosX + xRadius);
		var yRight = floor(PosY - yRadius);
			
		// Get roof distances
		var dLeft  = colmask_get_distance_v(xLeft, yLeft, false, TileSize)
		var dRight = colmask_get_distance_v(xRight, yRight, false, TileSize)
		
		// Use the shortest distance
		var Distance = dLeft <= dRight? dLeft : dRight;
		
		// If the distance is negative, we're touching the roof
		if Distance < 0
		{		
			// Collide 
			PosY -= Distance;
			
			// If moving upwards, check roof angle
			if abs(Ysp) > abs(Xsp)
			{	
				// Get roof angle
				var RoofAngle = dLeft <= dRight? colmask_get_angle_v(xLeft, yLeft, false) : colmask_get_angle_v(xRight, yRight, false);
				
				// Land on the roof if it is steep enough
				if RoofAngle < 135 or RoofAngle > 225
				{	
					Inertia  = RoofAngle < 180 ? -Ysp : Ysp;
					Angle	 = RoofAngle;					
					Grounded = true;
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