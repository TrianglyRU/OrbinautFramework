function PlayerHitFloor()
{
	// Exit the code if we're gliding or dead
	if !AllowCollision or GlidingState
	{
		exit;
	}
	
	// Mode is always RangeFloor when airborne
	AngleQuadEven = RangeFloor;
		
	// Check if we're moving horizontally faster than vertically, or moving downwards
	if (Ysp > 0 or abs(Xsp) > abs(Ysp))
	{	
		// Get tiles
		var TileLeft   = tile_check_collision_v(floor(PosX - xRadius), floor(PosY + yRadius), true, false, Layer);
		var TileRight  = tile_check_collision_v(floor(PosX + xRadius), floor(PosY + yRadius), true, false, Layer);
		var TileMiddle = tile_check_collision_v(floor(PosX),		   floor(PosY + yRadius), true, false, Layer);
			
		// Use left tile
		if TileLeft[0] <= TileRight[0]
		{
			var floorDistance = TileLeft[0];
			var floorAngle    = TileLeft[1];
		}
			
		// Use right tile
		else
		{
			var floorDistance = TileRight[0];
			var floorAngle    = TileRight[1];
		}
		
		// Use middle tile if both left and right distances are the same and we're on the flat floor
		if Game.ImprovedTileCollision
		{   
			if TileLeft[0] == TileRight[0] and TileMiddle[0] <= 0
			{
				var floorDistance = TileMiddle[0];
				var floorAngle	  = TileMiddle[1];
			}
		}
		
		// Check if we collide with the floor
		if floorDistance < 0
		{
			// If we're moving downwards and not gliding, calculate a momentum using floor angle
			if abs(Xsp) < abs(Ysp)
			{
				// Use vertical speed on steep angles
				if floorAngle >= 45 and floorAngle <= 315
				{
					if (Ysp > 16) Ysp = 16;
					Xsp		= 0;
					Inertia = floorAngle < 180 ? -Ysp : Ysp;
				}
		
				// Use halved vertical speed on shallow angles
				else if floorAngle >= 22.5 and floorAngle <= 337.5
				{
					Inertia = floorAngle <= 180 ? -Ysp / 2 : Ysp / 2;
				}
		
				// Use horizontal speed if angle is almost flat
				else 
				{	
					Ysp     = 0;
					Inertia = Xsp;	
				}
			}
		
			// If we're moving to the left or right, just use horizontal speed
			else 
			{	
				Ysp     = 0;
				Inertia = Xsp;
			}

			// Land
			PosY	+= floorDistance;
			Angle    = floorAngle;
			Grounded = true;
		}
	}
}