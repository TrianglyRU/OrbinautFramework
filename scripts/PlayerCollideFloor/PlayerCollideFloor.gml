function PlayerCollideFloor()
{	
	// Do not collide if we're not allowed to, or if we're standing on object
	if (!AllowCollision or OnObject) exit;

	// Collide with one of four floor sides based on floor angle range
	switch AngleRange
	{
		case RangeFloor:
		{		
			// Get tiles
			var TileLeft   = tile_check_collision_v(floor(PosX - xRadius), floor(PosY + yRadius), true, false, Layer);
			var TileRight  = tile_check_collision_v(floor(PosX + xRadius), floor(PosY + yRadius), true, false, Layer);
			var TileMiddle = tile_check_collision_v(floor(PosX),		   floor(PosY + yRadius), true, false, Layer);
			
			// Use middle tile
			if TileMiddle[0] < TileLeft[0] and TileMiddle[0] < TileRight[0]
			{
				var floorDistance = TileMiddle[0];
				var floorAngle	  = TileMiddle[1];
			}
			
			// Use left tile
			else if TileLeft[0] <= TileRight[0]
			{
				var floorDistance = TileLeft[0];
				var floorAngle	  = TileLeft[1];
				
				// Check for balancing
				if (TileMiddle[0] > 14 and Inertia == 0) Balancing = Facing;
			}
			
			// Use right tile
			else
			{
				var floorDistance = TileRight[0];
				var floorAngle	  = TileRight[1];
				
				// Check for balancing
				if (TileMiddle[0] > 14 and Inertia == 0) Balancing = -Facing;
			}

			// Perform floor collision
			var maxDistance = Game.SpeedFloorClip ? min(4 + abs(floor(Xsp)), 14) : 14;
			if  maxDistance <= floorDistance
			{
				Grounded = false;
				exit;
			}
			else //if floorDistance > -14
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
			else //if floorDistance > -14
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
			else //if floorDistance > -14
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
			else //if floorDistance > -14
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