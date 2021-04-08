function PlayerCollideFloor()
{	
	// Do not collide if we're not allowed to, or if we're standing on object
	if (!AllowCollision or OnObject) exit;
	
	// Collide with one of four floor sides based on floor angle range
	switch AngleRange//round(Angle/90) % 4
	{
		case RangeFloor:
		{		
			// Get tiles
			var tileDataLeft  = tile_check_collision_v(floor(PosX - xRadius), floor(PosY + yRadius), true, false, Layer);
			var tileDataRight = tile_check_collision_v(floor(PosX + xRadius), floor(PosY + yRadius), true, false, Layer);
			
			// Use tile with closest distance
			if tileDataLeft[0] <= tileDataRight[0]
			{
				var floorDistance = tileDataLeft[0];
				var floorAngle	  = tileDataLeft[1];
			}
			else
			{
				var floorDistance = tileDataRight[0];
				var floorAngle	  = tileDataRight[1];
			}
			
			// Perform floor collision
			var maxDistance = Game.SpeedFloorClip ? min(4 + abs(floor(Xsp)), 14) : 14;
			if floorDistance > maxDistance
			{
				Grounded = false;
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
			var tileDataLeft  = tile_check_collision_h(floor(PosX + yRadius), floor(PosY + xRadius), true, false, Layer);
			var tileDataRight = tile_check_collision_h(floor(PosX + yRadius), floor(PosY - xRadius), true, false, Layer);

			// Use tile with closest distance
			if tileDataLeft[0] <= tileDataRight[0]
			{
				var floorDistance = tileDataLeft[0];
				var floorAngle	  = tileDataLeft[1];
			}
			else
			{
				var floorDistance = tileDataRight[0];
				var floorAngle	  = tileDataRight[1];
			}
			
			// Perform floor collision
			var maxDistance = Game.SpeedFloorClip ? min(4 + abs(floor(Ysp)), 14) : 14;
			if floorDistance > maxDistance
			{
				Grounded = false;
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
			var tileDataLeft  = tile_check_collision_v(floor(PosX + xRadius), floor(PosY - yRadius), false, false, Layer);
			var tileDataRight = tile_check_collision_v(floor(PosX - xRadius), floor(PosY - yRadius), false, false, Layer);
			
			// Use tile with closest distance
			if tileDataLeft[0] <= tileDataRight[0]
			{
				var floorDistance = tileDataLeft[0];
				var floorAngle	  = tileDataLeft[1];
			}
			else
			{
				var floorDistance = tileDataRight[0];
				var floorAngle    = tileDataRight[1];
			}
			
			// Perform floor collision
			var maxDistance = Game.SpeedFloorClip ? min(4 + abs(floor(Xsp)), 14) : 14;
			if floorDistance > maxDistance
			{
				Grounded = false;
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
			var tileDataLeft  = tile_check_collision_h(floor(PosX - yRadius), floor(PosY - xRadius), false, false, Layer);
			var tileDataRight = tile_check_collision_h(floor(PosX - yRadius), floor(PosY + xRadius), false, false, Layer);
			
			// Use tile with closest distance
			if tileDataLeft[0] <= tileDataRight[0]
			{
				var floorDistance = tileDataLeft[0];
				var floorAngle    = tileDataLeft[1];
			}
			else
			{
				var floorDistance = tileDataRight[0];
				var floorAngle    = tileDataRight[1];
			}
			

			// Perform floor collision
			var maxDistance = Game.SpeedFloorClip ? min(4 + abs(floor(Ysp)), 14) : 14;
			if floorDistance > maxDistance
			{
				Grounded = false;
			}
			else //if floorDistance > -14
			{
				PosX -= floorDistance;
			}
		}
		break;
	}
	
	// Update player's angle
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
		if (Angle = 0) Angle = 360;
	}
	else
	{
		Angle = floorAngle;
	}
	
	// Store values to display in debug
	Screen.DebugValue[0] = tileDataLeft[0];
	Screen.DebugValue[1] = tileDataRight[0];
	Screen.DebugValue[2] = tileDataLeft[1];
	Screen.DebugValue[3] = tileDataRight[1];
	Screen.DebugValue[4] = tileDataLeft[0] <= tileDataRight[0] ? "LEFT" : "RIGHT";
}