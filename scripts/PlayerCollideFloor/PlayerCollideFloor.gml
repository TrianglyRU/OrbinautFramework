function PlayerCollideFloor()
{	
	// Do not collide if we're not allowed to, or if we're standing on object
	if (!AllowCollision or OnObject) exit;
	
	// Update collision mode
	if Grounded
	{
		// Use original mode change method based on current angle
		if !Game.SmoothModeUpdate or Rolling
		{
			if Angle >= 0 and Angle <= 45 or Angle >= 315 and Angle <= 360
			{
				FloorRange = RangeFloor;
			}
			if Angle >= 46 and Angle <= 134
			{
				FloorRange = RangeRWall;
			}
			if Angle >= 135 and Angle <= 225
			{
				FloorRange = RangeRoof;
			}
			if Angle >= 226 and Angle <= 314
			{
				FloorRange = RangeLWall;
			}
		}
		
		// Use custom advanced method using tile detection (smoother, but inaccurate to originals)
		else if !Rolling
		{
			// Set maximum angle difference. If difference exceeds this value, mode won't change
			var angleTolerance = 45;
		
			switch FloorRange
			{
				case RangeFloor:
				{
					// Get tiles
					var leftTile  = tile_check_collision_h(floor(PosX - yRadius), floor(PosY + xRadius), false, true, Layer)
					var rightTile = tile_check_collision_h(floor(PosX + yRadius), floor(PosY + xRadius), true, true, Layer)
				
					// Check if we move left and collide with left tile
					if leftTile[0] < 0 and Angle - leftTile[1] < angleTolerance
					{
						// Enter left wall collision mode
						FloorRange = RangeLWall;
					}
				
					// Check if move right and collide with right tile
					if rightTile[0] < 0 and rightTile[1] - Angle mod 360 < angleTolerance
					{
						// Enter right wall collision mode
						FloorRange = RangeRWall;
					}
				}
				break;
				case RangeRWall:
				{
					// Get tiles
					var leftTile  = tile_check_collision_v(floor(PosX + xRadius), floor(PosY + yRadius), true, true, Layer);
					var rightTile = tile_check_collision_v(floor(PosX + xRadius), floor(PosY - yRadius), false, true, Layer);
				
				
					// Check if we collide left tile and angle difference isn't greater than 45
					if leftTile[0] < 0 and Angle - leftTile[1] < angleTolerance
					{
						// Enter floor collision mode
						FloorRange = RangeFloor;
					}
				
					// Check if we collide right tile and angle difference isn't greater than 45
					if rightTile[0] < 0 and rightTile[1] - Angle mod 360 < angleTolerance
					{
						// Enter roof collision mode
						FloorRange = RangeRoof;
					}
				}
				case RangeRoof:
				{
					// Get tiles
					var leftTile  = tile_check_collision_h(floor(PosX + yRadius), floor(PosY - xRadius), true, true, Layer)
					var rightTile = tile_check_collision_h(floor(PosX - yRadius), floor(PosY - xRadius), false, true, Layer)
				
					// Check if we collide left tile and angle difference isn't greater than 45
					if leftTile[0] < 0 and Angle - leftTile[1] < angleTolerance
					{
						// Enter right wall collision mode
						FloorRange = RangeRWall;
					}
				
					// Check if we collide right tile and angle difference isn't greater than 45
					if rightTile[0] < 0 and rightTile[1] - Angle mod 360 < angleTolerance
					{
						// Enter left wall collision mode
						FloorRange = RangeLWall;
					}
				}
				break;
				case RangeLWall:
				{
					// Get tiles
					var leftTile  = tile_check_collision_v(floor(PosX - xRadius), floor(PosY - yRadius), false, true, Layer);
					var rightTile = tile_check_collision_v(floor(PosX - xRadius), floor(PosY + yRadius), true,  true, Layer);				
				
					// Check if we collide left tile and angle difference isn't greater than 45
					if leftTile[0] < 0 and Angle - leftTile[1] < angleTolerance
					{
						// Enter roof collision mode
						FloorRange = RangeRoof;
					}
				
					// Check if we collide right tile and angle difference isn't greater than 45
					if rightTile[0] < 0 and rightTile[1] - Angle mod 360 <= 90
					{
						// Enter floor collision mode
						FloorRange = RangeFloor;
					}
				}
				break;
			}
		}
	}
	else
	{
		// Mode is always RangeFloor when airborne
		FloorRange = RangeFloor;
	}
	
	// Ground collision
	if Grounded
	{
		// Collide with one of four floor sides based on floor angle range
		switch FloorRange
		{
			case RangeFloor:
			{		
				// Get tiles
				var TileLeft   = tile_check_collision_v(floor(PosX - xRadius), floor(PosY + yRadius), true, false, Layer);
				var TileRight  = tile_check_collision_v(floor(PosX + xRadius), floor(PosY + yRadius), true, false, Layer);
				var TileMiddle = tile_check_collision_v(floor(PosX),		   floor(PosY + yRadius), true, false, Layer);
			
				// Use left tile (primary)
				if TileLeft[0] <= TileRight[0]
				{
					var floorDistance = TileLeft[0];
					var floorAngle	  = TileLeft[1];
					
					// Check for balancing
					if (Inertia == 0 and TileMiddle[0] > 14) Balancing = Facing;
				}
			
				// Use right tile (secondary)
				else
				{
					var floorDistance = TileRight[0];
					var floorAngle	  = TileRight[1];

					// Check for balancing
					if (Inertia == 0 and TileMiddle[0] > 14) Balancing = -Facing;
				}
				
				
				/* Originals don't use middle floor sensor to collide with surface, but we do to fix certain flaws.
				   This is forced from our side and there is no flag to turn if off, you can just delete it instead */
				{   
					// Use middle tile if both left and right distances are the same and we're on the flat floor
					if TileLeft[0] == TileRight[0] and TileMiddle[0] <= 0
					{
						var floorDistance = TileMiddle[0];
						var floorAngle	  = TileMiddle[1];
					}
				}
				
				// Check if floor angle difference is too high
				var angDifference = abs(Angle mod 180 - floorAngle mod 180);
				if  angDifference > 45 and angDifference < 135
				{
					// Lose the ground...
					if Game.ConsiderAngleDifference
					{
						Grounded = false;
						exit;
					}
					
					// ...or just force reset floor angle
					else
					{
						Balancing  = false;
						floorAngle = 360;
					}
				}
				
				// Lose the ground if distance is too high
				var maxDistance  = Game.SpeedFloorClip ? min(4 + abs(floor(Xsp)), 14) : 14;
				if  maxDistance <= floorDistance
				{
					Grounded = false;
					exit;
				}
				
				// Collide with floor
				else if floorDistance > -14
				{
					Angle = floorAngle;
					PosY += floorDistance;
				}
			}
			break;
			case RangeRWall:
			{	
				// Get tiles
				var TileLeft  = tile_check_collision_h(floor(PosX + yRadius), floor(PosY + xRadius), true, false, Layer);
				var TileRight = tile_check_collision_h(floor(PosX + yRadius), floor(PosY - xRadius), true, false, Layer);
			
				// Use left tile
				if TileLeft[0] <= TileRight[0]
				{
					var floorDistance = TileLeft[0];
					var floorAngle	  = TileLeft[1];
				}
			
				// Use right tile
				else
				{
					var floorDistance = TileRight[0];
					var floorAngle	  = TileRight[1];
				}
			
				// Lose the ground if distance is too high
				var maxDistance  = Game.SpeedFloorClip ? min(4 + abs(floor(Ysp)), 14) : 14;
				if  maxDistance <= floorDistance
				{
					Grounded = false;
					exit;
				}
				
				// Collide with floor
				else //if floorDistance > -14
				{
					Angle = floorAngle;
					PosX += floorDistance;
				}
			}
			break;
			case RangeRoof:	
			{	
				// Get tiles
				var TileLeft  = tile_check_collision_v(floor(PosX + xRadius), floor(PosY - yRadius), false, false, Layer);
				var TileRight = tile_check_collision_v(floor(PosX - xRadius), floor(PosY - yRadius), false, false, Layer);
			
				// Use left tile
				if TileLeft[0] <= TileRight[0]
				{
					var floorDistance = TileLeft[0];
					var floorAngle	  = TileLeft[1];
				}
			
				// Use right tile
				else
				{
					var floorDistance = TileRight[0];
					var floorAngle    = TileRight[1];
				}
			
				// Lose the ground if distance is too high
				var maxDistance  = Game.SpeedFloorClip ? min(4 + abs(floor(Xsp)), 14) : 14;
				if  maxDistance <= floorDistance
				{
					Grounded = false;
					exit;
				}
				
				// Collide with floor
				else //if floorDistance > -14
				{
					Angle = floorAngle;
					PosY -= floorDistance;
				}
			}
			break;
			case RangeLWall:
			{	
				// Get tiles
				var TileLeft  = tile_check_collision_h(floor(PosX - yRadius), floor(PosY - xRadius), false, false, Layer);
				var TileRight = tile_check_collision_h(floor(PosX - yRadius), floor(PosY + xRadius), false, false, Layer);
			
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
			
				// Lose the ground if distance is too high
				var maxDistance  = Game.SpeedFloorClip ? min(4 + abs(floor(Ysp)), 14) : 14;
				if  maxDistance <= floorDistance
				{
					Grounded = false;
					exit;
				}
				
				// Collide with floor
				else//if floorDistance > -14
				{
					Angle = floorAngle;
					PosX -= floorDistance;
				}
			}
			break;
		}
	}
	
	// Airborne collision
	else
	{
		// Check if we're moving horizontally faster than vertically, or moving downwards
		if (Ysp > 0 or abs(Xsp) > abs(Ysp))
		{	
			// Get tiles
			var TileLeft   = tile_check_collision_v(floor(PosX - xRadius), floor(PosY + yRadius), true, false, Layer);
			var TileRight  = tile_check_collision_v(floor(PosX + xRadius), floor(PosY + yRadius), true, false, Layer);
			
			// Use left tile
			if TileLeft[0] <= TileRight[0]
			{
				var floorDistance = TileLeft[0];
				var floorAngle	  = TileLeft[1];
			}
			
			// Use right tile
			else
			{
				var floorDistance = TileRight[0];
				var floorAngle	  = TileRight[1];
			}
		
			// Check if we're inside the floor
			if floorDistance < 0
			{
				// If we're moving downwards, calculate a momentum using floor angle
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
		
				// Adhere to the floor and apply angle to player
				PosY += floorDistance;
				Angle = floorAngle;
				
				// Set flag
				Grounded   = true;
			}
		}
	}
}