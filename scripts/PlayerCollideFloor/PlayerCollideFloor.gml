function PlayerCollideFloor()
{	
	// Do not collide if we're not allowed to, or if we're standing on object
	if (!AllowCollision or OnObject) exit;
	
	// Update floor collision mode
	/*if Grounded
	{
		if Angle >= 0 and Angle <= 45 or Angle >= 315 and Angle <= 360
		{
			FloorRange = RangeFloor;
		}
		else if Angle >= 46 and Angle <= 134
		{
			FloorRange = RangeRWall;
		}
		else if Angle >= 135 and Angle <= 225
		{
			FloorRange = RangeRoof;
		}
		else if Angle >= 226 and Angle <= 314
		{
			FloorRange = RangeLWall;
		}
	}
	else
	{
		FloorRange = RangeFloor;
	}*/
	if Grounded
	{
		switch FloorRange
		{
			case RangeFloor:
			{
				var CheckLeft  = [PosX - xRadius * 2, PosY + yRadius / 2];
				var CheckRight = [PosX + xRadius * 2, PosY + yRadius / 2];
			}
			break;
			case RangeRWall:
			{
				var CheckLeft  = [PosX + yRadius / 2, PosY - xRadius * 2];
				var CheckRight = [PosX + yRadius / 2, PosY + xRadius * 2];
			}
			break;
			case RangeRoof:
			{
				var CheckLeft  = [PosX - xRadius * 2, PosY - yRadius / 2];
				var CheckRight = [PosX + xRadius * 2, PosY - yRadius / 2];
			}
			break;
			case RangeLWall:
			{
				var CheckLeft  = [PosX - yRadius / 2, PosY - xRadius * 2];
				var CheckRight = [PosX - yRadius / 2, PosY + xRadius * 2];
			}
			break;
		}
		
		if tile_meeting(floor(CheckLeft[0]),  floor(CheckLeft[1]),  Layer)
		or tile_meeting(floor(CheckRight[0]), floor(CheckRight[1]), Layer)
		{
			FloorRange = round(Angle/90) mod 4;
		}
	}
	else
	{
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
			
				// Use left tile
				if TileLeft[0] < TileRight[0]
				{
					var floorDistance = TileLeft[0];
					var floorAngle	  = TileLeft[1];
				
					// Check for balancing
					if (TileMiddle[0] > 14 and Inertia == 0) Balancing = Facing;
				}
			
				// Use right tile
				else if TileLeft[0] > TileRight[0]
				{
					var floorDistance = TileRight[0];
					var floorAngle	  = TileRight[1];
				
					// Check for balancing
					if (TileMiddle[0] > 14 and Inertia == 0) Balancing = -Facing;
				}
				
				// Use middle tile 
				/* Originals don't use middle floor sensor for floor collision, but we do to make collision work better */
				else
				{
					var floorDistance = TileMiddle[0];
					var floorAngle	  = TileMiddle[1];
				}

				// Perform floor collision
				var maxDistance = Game.SpeedFloorClip ? min(4 + abs(floor(Xsp)), 14) : 14;
				if  maxDistance <= floorDistance
				{
					Grounded = false;
					exit;
				}
				else if floorDistance > -14
				{
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
			
				// Perform floor collision
				var maxDistance = Game.SpeedFloorClip ? min(4 + abs(floor(Ysp)), 14) : 14;
				if  maxDistance <= floorDistance
				{
					Grounded = false;
					exit;
				}
				else if floorDistance > -14
				{
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
			
				// Perform floor collision
				var maxDistance = Game.SpeedFloorClip ? min(4 + abs(floor(Xsp)), 14) : 14;
				if  maxDistance <= floorDistance
				{
					Grounded = false;
					exit;
				}
				else if floorDistance > -14
				{
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
			
				// Perform floor collision
				var maxDistance = Game.SpeedFloorClip ? min(4 + abs(floor(Ysp)), 14) : 14;
				if  maxDistance <= floorDistance
				{
					Grounded = false;
					exit;
				}
				else if floorDistance > -14
				{
					PosX -= floorDistance;
				}
			}
			break;
		}
	
		// Update movement angle
		if Game.ConsiderAngleDifference
		{
			var angDifference = abs(Angle - floorAngle);
			if (angDifference < 180 and angDifference > 45) or (angDifference >= 180 and angDifference < 315)
			{
				Angle     = (round(Angle/90) % 4) * 90;
				Balancing = false;
			}
			else
			{
				Angle = floorAngle;
			}
			if (Angle == 0) Angle = 360;
		}
		else
		{
			Angle = floorAngle;
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
			var TileMiddle = tile_check_collision_v(floor(PosX),		   floor(PosY + yRadius), true, false, Layer);
			
			// Use left tile
			if TileLeft[0] < TileRight[0]
			{
				var floorDistance = TileLeft[0];
				var floorAngle	  = TileLeft[1];
				
				// Check for balancing
				if (TileMiddle[0] > 14 and Inertia == 0) Balancing = Facing;
			}
			
			// Use right tile
			else if TileLeft[0] > TileRight[0]
			{
				var floorDistance = TileRight[0];
				var floorAngle	  = TileRight[1];
				
				// Check for balancing
				if (TileMiddle[0] > 14 and Inertia == 0) Balancing = -Facing;
			}
				
			// Use middle tile
			/* Originals don't use middle floor sensor for floor collision, but we do to make collision work better */
			else
			{
				var floorDistance = TileMiddle[0];
				var floorAngle	  = TileMiddle[1];
			}
		
			// Perform floor collision
			if floorDistance < 0
			{
				// If we're moving downwards, calculate a momentum using floor angle
				if abs(Xsp) < abs(Ysp)
				{
					// If angle is >= 45 degrees, use vertical speed
					if floorAngle >= 45 and floorAngle <= 315
					{
						if (Ysp > 16) Ysp = 16;
						Xsp		= 0;
						Inertia = floorAngle < 180 ? -Ysp : Ysp;
					}
		
					// If angle is >= 22.5 degrees, use halved vertical speed
					else if floorAngle >= 22.5 and floorAngle <= 337.5
					{
						Inertia = floorAngle <= 180 ? -Ysp / 2 : Ysp / 2;
					}
		
					// If angle is < 22.5 degrees, use horizontal speed
					else 
					{	
						Ysp     = 0;
						Inertia = Xsp;	
					}
				}
		
				// If we're moving to the left or right, use xsp
				else 
				{	
					Ysp     = 0;
					Inertia = Xsp;
				}
		
				// Land and adhere to the floor
				PosY	  += floorDistance;
				Angle	   = floorAngle;
				Grounded   = true;
			}
		}
	}
}