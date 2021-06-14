function PlayerAnglePos()
{	
	// Do not collide if we're not allowed to, or if we're standing on object
	if !AllowCollision or OnObject
	{
		exit;
	}
	
	// Use original mode change method based on current angle
	if !Game.ImprovedTileCollision
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
	else
	{
		// Set maximum angle difference. If difference exceeds this value, mode won't change
		var angleTolerance = 45;
		
		switch FloorRange
		{
			case RangeFloor:
			{
				// Get tiles
				var leftTile  = tile_check_collision_h(floor(PosX - yRadius), floor(PosY + xRadius), false, true, Layer)
				var rightTile = tile_check_collision_h(floor(PosX + yRadius), floor(PosY + xRadius), true,  true, Layer)
				
				// Check if we collide left tile and angle difference isn't greater than 45
				if leftTile[0] < 0 and Angle - leftTile[1] < angleTolerance
				{
					// Enter left wall collision mode
					FloorRange = RangeLWall;
				}
				
				// Check if we collide right tile and angle difference isn't greater than 45
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
				var leftTile  = tile_check_collision_v(floor(PosX + xRadius), floor(PosY + yRadius), true,  true, Layer);
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
				var leftTile  = tile_check_collision_h(floor(PosX + yRadius), floor(PosY - xRadius), true,  true, Layer)
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
				if rightTile[0] < 0 and rightTile[1] - Angle mod 360 < angleTolerance
				{
					// Enter floor collision mode
					FloorRange = RangeFloor;
				}
			}
			break;
		}
		
		// Update collision mode normally in case advanced method will fail
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
				
			// Use middle tile if both left and right distances are the same and we're on the flat floor
			if Game.ImprovedTileCollision
			{   
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
				// Force reset floor angle
				floorAngle = 360;
				
				// Walk off of the edge naturally
				if Game.ImprovedTileCollision
				{
					// Extra check for balancing
					if (Inertia == 0 and TileMiddle[0] > 0) Balancing = -Facing;

					// Go airborne if there is no ground right below us
					if floorDistance > 0
					{
						Grounded = false;
						exit;
					}
				}
					
				// or just disable balancing
				else
				{
					Balancing = false;
				}
			}
				
			// Lose the ground if distance is too high
			var maxDistance = Game.SpeedFloorClip ? min(4 + abs(floor(Xsp)), 14) : 14;
			if floorDistance > maxDistance
			{
				Grounded = false;
				exit;
			}
				
			// Collide with floor
			else if floorDistance >= -14
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
			if  floorDistance > maxDistance
			{
				Grounded = false;
				exit;
			}
				
			// Collide with floor
			else if floorDistance >= -14
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
			if floorDistance > maxDistance
			{
				Grounded = false;
				exit;
			}
				
			// Collide with floor
			else if floorDistance >= -14
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
			if floorDistance > maxDistance
			{
				Grounded = false;
				exit;
			}
				
			// Collide with floor
			else if floorDistance >= -14
			{
				Angle = floorAngle;
				PosX -= floorDistance;
			}
		}
		break;
	}
}