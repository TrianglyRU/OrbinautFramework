function PlayerAnglePos()
{	
	// Exit the code if we're not allowed to collide or we're standing on object
	if !AllowCollision or OnObject
	{
		exit;
	}
	
	// Get current angle range of the floor
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
	
	// Collide with the surface depending on current angle range
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
				// Use left tile
				var FloorDistance = TileLeft[0];
				var FloorAngle	  = TileLeft[1];
					
				// Check for balancing on the left
				if Inertia == 0 and TileMiddle[0] > 14
				{
					Balancing = Facing;
				}
			}
			
			// Else use right tile
			else
			{	
				var FloorDistance = TileRight[0];
				var FloorAngle	  = TileRight[1];

				// Check for balancing on the right
				if Inertia == 0 and TileMiddle[0] > 14
				{
					Balancing = -Facing;
				}
			}
				
			// Is the tile below our position is closer to us than tiles on the left and right?
			if Game.ImprovedTileCollision
			{   
				if TileLeft[0] == TileRight[0] and TileMiddle[0] <= 0
				{
					// Use the tile right below our position
					var FloorDistance = TileMiddle[0];
					var FloorAngle	  = TileMiddle[1];
				}
			}
				
			// Check if the difference between our angle and floor angle is too high
			var Difference = abs(Angle mod 180 - FloorAngle mod 180);
			if  Difference > 45 and Difference < 135
			{
				// Force reset floor angle
				FloorAngle = 360;
				
				// Should we walk off of the edge naturally?
				if Game.ImprovedTileCollision
				{
					// Extra check for balancing on the slope
					if Inertia == 0 and TileMiddle[0] > 0
					{
						Balancing = -Facing;
					}

					// Go airborne if there is no surface right below us
					if FloorDistance > 0
					{
						Grounded = false;
						exit;
					}
				}
					
				// If not, just ignore balancing
				else
				{
					Balancing = false;
				}
			}
				
			// Go airborne if the surface is far below us
			var Distance = Game.SpeedFloorClip ? min(4 + abs(floor(Xsp)), 14) : 14;
			if  FloorDistance > Distance
			{
				Grounded = false;
			}
				
			// Else adhere to the surface and inherit floor angle
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
			// Get the tiles to the right from us
			var TileLeft  = tile_check_collision_h(floor(PosX + yRadius), floor(PosY + xRadius), true, false, Layer);
			var TileRight = tile_check_collision_h(floor(PosX + yRadius), floor(PosY - xRadius), true, false, Layer);
			
			// Is the lower tile closer to us than the higher one?
			if TileLeft[0] <= TileRight[0]
			{
				// Use lower tile
				var FloorDistance = TileLeft[0];
				var FloorAngle	  = TileLeft[1];
			}
			
			// Else use higher tile
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
				
			// Else adhere to the surface and inherit floor angle
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
			var TileLeft  = tile_check_collision_v(floor(PosX + xRadius), floor(PosY - yRadius), false, false, Layer);
			var TileRight = tile_check_collision_v(floor(PosX - xRadius), floor(PosY - yRadius), false, false, Layer);
			
			// Is the right tile closer to us than the left one?
			if TileLeft[0] <= TileRight[0]
			{
				// Use right tile
				var FloorDistance = TileLeft[0];
				var FloorAngle	  = TileLeft[1];
			}
			
			// Else use left tile
			else
			{
				var FloorDistance = TileRight[0];
				var FloorAngle    = TileRight[1];
			}
			
			// Go airborne if the surface is far above us
			var Distance  = Game.SpeedFloorClip ? min(4 + abs(floor(Xsp)), 14) : 14;
			if  FloorDistance > Distance
			{
				Grounded = false;
			}
				
			// Else adhere to the surface and inherit floor angle
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
			// Get the tiles to the right from us
			var TileLeft  = tile_check_collision_h(floor(PosX - yRadius), floor(PosY - xRadius), false, false, Layer);
			var TileRight = tile_check_collision_h(floor(PosX - yRadius), floor(PosY + xRadius), false, false, Layer);
			
			// Is the higher tile closer to us than the lower one?
			if TileLeft[0] <= TileRight[0]
			{
				// Use higher tile
				var FloorDistance = TileLeft[0];
				var FloorAngle    = TileLeft[1];
			}
			
			// Else use lower tile
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
				
			// Else adhere to the surface and inherit floor angle
			else if FloorDistance >= -14
			{
				Angle = FloorAngle;
				PosX -= FloorDistance;
			}
		}
		break;
	}
}
