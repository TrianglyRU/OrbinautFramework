function PlayerAnglePos()
{	
	// Do not collide if we're not allowed to, or if we're standing on object
	if !AllowCollision or OnObject
	{
		exit;
	}
	
	// Update floor angle quadrant
	if Angle >= 0 and Angle < 46 or Angle > 314 and Angle <= 360	
	{
		// 0.0 ~ 45.9 | 360.0 ~ 315.9
		AngleQuadFloor = RangeFloor;
	}
	else if Angle >= 46 and Angle < 135			
	{
		// 46.0 ~ 134.9
		AngleQuadFloor = RangeRWall;
	}
	else if Angle >= 135 and Angle < 226		
	{
		// 135.0 ~ 225.9
		AngleQuadFloor = RangeRoof;
	}
	else if Angle >= 226 and Angle <= 314		
	{
		// 226.0 ~ 314.0
		AngleQuadFloor = RangeLWall;
	}

	// Collide with one of four floor sides based on floor angle range
	switch AngleQuadFloor
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