function PlayerCollideRoof()
{	
	// Do not collide if we're not allowed to
	if (Ysp < 0 or abs(Xsp) > abs(Ysp)) and AllowCollision
	{
		// Get tiles
		var tileDataLeft  = tile_check_collision_v(floor(PosX - xRadius), floor(PosY - yRadius), false, true, Layer);
		var tileDataRight = tile_check_collision_v(floor(PosX + xRadius), floor(PosY - yRadius), false, true, Layer);
		
		// Use tile with closest distance
		if tileDataLeft[0] <= tileDataRight[0]
		{
			var roofDistance = tileDataLeft[0];
			var roofAngle    = tileDataLeft[1];
		}
		else
		{
			var roofDistance = tileDataRight[0];
			var roofAngle    = tileDataRight[1];
		}
			
		// Perform roof collision
		if roofDistance < 0
		{	
			// Push out off the roof
			PosY -= roofDistance;
			
			// If moving upwards and not flying, check roof angle
			if abs(Ysp) > abs(Xsp) and !FlyingState
			{	
				// Land on the roof if it is steep enough
				if roofAngle > 90 and roofAngle <= 135 or roofAngle >= 225 and roofAngle < 270
				{						
					Grounded   = true;
					FloorRange = RangeRoof;
					Angle      = roofAngle;
					Inertia    = roofAngle < 180 ? -Ysp : Ysp;
					PosY      -= Ysp;
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