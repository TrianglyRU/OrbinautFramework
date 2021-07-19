function PlayerAnglePos()
{	
	// Exit the code if collisions are disabled or we are standing on the object
	if !AllowCollision or OnObject
	{
		exit;
	}
	
	// Get the current range of angles
	if Angle <= 45 or Angle >= 315
	{
		var AngleRange = RangeFloor;
	}
	else if Angle >= 46.41 and Angle <= 133.59		
	{
		var AngleRange = RangeRWall;
	}
	else if Angle >= 135 and Angle <= 225		
	{
		var AngleRange = RangeRoof;
	}
	else if Angle >= 226.41 and Angle <= 313.59		
	{
		var AngleRange = RangeLWall;
	}	
	
	// Сollide with the surface based on the current range of angles
	switch AngleRange
	{
		// Handle floor collision
		case RangeFloor:
		{		
			// Get the tiles below us
			var TileLeft   = tile_check_collision_v(floor(PosX - xRadius), floor(PosY + yRadius), true, false, Layer);
			var TileRight  = tile_check_collision_v(floor(PosX + xRadius), floor(PosY + yRadius), true, false, Layer);
			var TileMiddle = tile_check_collision_v(floor(PosX),	       floor(PosY + yRadius), true, false, Layer);
			
			// Is the left tile closer to us than the right one?
			if TileLeft[0] <= TileRight[0]
			{
				// Use the left tile
				var FloorDistance = TileLeft[0];
				var FloorAngle	  = TileLeft[1];
			}
			
			// Else use the right tile
			else
			{	
				var FloorDistance = TileRight[0];
				var FloorAngle	  = TileRight[1];
			}
				
			// Is the tile below our position closer to us than the tiles on the left and right?
			if Game.ImprovedTileCollision
			{   
				if TileLeft[0] == TileRight[0] and TileMiddle[0] <= 0
				{
					// Use the tile below our position
					var FloorDistance = TileMiddle[0];
					var FloorAngle	  = TileMiddle[1];
				}
			}
				
			// Is the difference between our angle and the floor angle greater than 45 degrees?
			var Difference = abs(Angle mod 180 - FloorAngle mod 180);
			if  Difference > 45 and Difference < 135
			{
				// Force reset the floor angle
				FloorAngle = 360;
				
				// Should we walk off the slope naturally?
				if Game.ImprovedTileCollision
				{
					// Changing our state if there is no surface right below us 
					if FloorDistance > 0
					{
						Grounded = false;
						exit;
					}
				}
			}
				
			// Lose ground if the surface below us is too far away
			var Distance = Game.SpeedFloorClip ? min(4 + abs(floor(Xsp)), 14) : 14;
			if  FloorDistance > Distance
			{
				Grounded = false;
			}
				
			// Else adhere to the surface and inherit the floor angle
			else if FloorDistance >= -14
			{
				Angle = FloorAngle;
				PosY += FloorDistance;
			}
		}
		break;
			
		// Handle right wall collision
		case RangeRWall:
		{	
			// Get the tiles to our right
			var TileLeft  = tile_check_collision_h(floor(PosX + yRadius), floor(PosY + xRadius), true, false, Layer);
			var TileRight = tile_check_collision_h(floor(PosX + yRadius), floor(PosY - xRadius), true, false, Layer);
			
			// Is the bottom tile closer to us than the top one?
			if TileLeft[0] <= TileRight[0]
			{
				// Use the bottom tile
				var FloorDistance = TileLeft[0];
				var FloorAngle	  = TileLeft[1];
			}
			
			// Else use the top tile
			else
			{
				var FloorDistance = TileRight[0];
				var FloorAngle	  = TileRight[1];
			}
			
			// Go airborne if the surface is far to the right from us
			var Distance = Game.SpeedFloorClip ? min(4 + abs(floor(Ysp)), 14) : 14;
			if  FloorDistance > Distance
			{
				Grounded = false;
			}
				
			// Else adhere to the surface and inherit the floor angle
			else if FloorDistance >= -14
			{
				Angle = FloorAngle;
				PosX += FloorDistance;
			}
		}
		break;
			
		// Handle roof collision
		case RangeRoof:	
		{	
			// Get the tiles above us
			var TileLeft  = tile_check_collision_v(floor(PosX - xRadius), floor(PosY - yRadius), false, false, Layer);
			var TileRight = tile_check_collision_v(floor(PosX + xRadius), floor(PosY - yRadius), false, false, Layer);
			
			// Is the right tile closer to us than the left one?
			if TileRight[0] <= TileLeft[0]
			{
				// Use the right tile
				var FloorDistance = TileRight[0];
				var FloorAngle	  = TileRight[1];
			}
			
			// Else use the left tile
			else
			{
				var FloorDistance = TileLeft[0];
				var FloorAngle    = TileLeft[1];
			}
			
			// Go airborne if the surface above us is too far away
			var Distance = Game.SpeedFloorClip ? min(4 + abs(floor(Xsp)), 14) : 14;
			if  FloorDistance > Distance
			{
				Grounded = false;
			}
				
			// Else adhere to the surface and inherit the floor angle
			else if FloorDistance >= -14
			{
				Angle = FloorAngle;
				PosY -= FloorDistance;
			}
		}
		break;
			
		// Handle left wall collision
		case RangeLWall:
		{	
			// Get the tiles to our left
			var TileLeft  = tile_check_collision_h(floor(PosX - yRadius), floor(PosY - xRadius), false, false, Layer);
			var TileRight = tile_check_collision_h(floor(PosX - yRadius), floor(PosY + xRadius), false, false, Layer);
			
			// Is the top tile closer to us than the bottom one?
			if TileLeft[0] <= TileRight[0]
			{
				// Use the top tile
				var FloorDistance = TileLeft[0];
				var FloorAngle    = TileLeft[1];
			}
			
			// Else use the bottom tile
			else
			{
				var FloorDistance = TileRight[0];
				var FloorAngle    = TileRight[1];
			}
			
			// Go airborne if the surface is far to the left from us
			var Distance = Game.SpeedFloorClip ? min(4 + abs(floor(Ysp)), 14) : 14;
			if  FloorDistance > Distance
			{
				Grounded = false;
			}
				
			// Else adhere to the surface and inherit the floor angle
			else if FloorDistance >= -14
			{
				Angle = FloorAngle;
				PosX -= FloorDistance;
			}
		}
		break;
	}
}
