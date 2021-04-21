function PlayerCollideFloor()
{	
	// Do not collide if we're not allowed to, or if we're standing on object
	if (!AllowCollision or OnObject) exit;
	
	// Check if we find tiles at given positions before trying to change our angle range
	/* This is not a thing in the originals, we do this to make collision more stable */
	switch AngleRange
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
	}
	if tile_meeting(floor(CheckLeft[0]),  floor(CheckLeft[1]),  Layer)
	or tile_meeting(floor(CheckRight[0]), floor(CheckRight[1]), Layer)
	{
		AngleRange = round(Angle/90) % 4;
	}
	
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
		if  angDifference < 180
		{
			Angle = angDifference > 45  ? (round(Angle/90) % 4) * 90 : floorAngle;
		}
		else
		{
			Angle = angDifference < 315 ? (round(Angle/90) % 4) * 90 : floorAngle;
		}
		if (Angle == 0) Angle = 360;
	}
	else
	{
		Angle = floorAngle;
	}
}