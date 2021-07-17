function PlayerHitFloor()
{
	// Exit the code if we're not allowed to collide or we're gliding as Knuckles
	if !AllowCollision or GlidingState
	{
		exit;
	}
	
	// Check if we're moving horizontally faster than vertically, or downwards
	if (Ysp > 0 or abs(Xsp) >= abs(Ysp))
	{	
		// Get the tiles below us
		var TileLeft   = tile_check_collision_v(floor(PosX - xRadius), floor(PosY + yRadius), true, false, Layer);
		var TileRight  = tile_check_collision_v(floor(PosX + xRadius), floor(PosY + yRadius), true, false, Layer);
		var TileMiddle = tile_check_collision_v(floor(PosX),		   floor(PosY + yRadius), true, false, Layer);
			
		// Is the left tile closer to us than the right one?
		if TileLeft[0] <= TileRight[0]
		{
			// Use left tile
			var FloorDistance = TileLeft[0];
			var FloorAngle    = TileLeft[1];
		}
			
		// Else use right tile
		else
		{	
			var FloorDistance = TileRight[0];
			var FloorAngle    = TileRight[1];
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
		
		// Are we touching the floor within the clip distance?
		var ClipDistance = -(Ysp + 8)
		if  FloorDistance < 0 and (TileLeft[0] >= ClipDistance or TileRight[0] >= ClipDistance)
		{
			// Use full vertical speed on steep angles
			if FloorAngle >= 46.41 and FloorAngle <= 315
			{
				Xsp = 0;
				Inertia = FloorAngle < 180 ? -Ysp : Ysp;
			}
		
			// Use halved vertical speed on shallow angles
			else if FloorAngle >= 23.91 and FloorAngle <= 337.5
			{
				Inertia = FloorAngle < 180 ? -Ysp / 2 : Ysp / 2;
			}
		
			// Use horizontal speed if angle is almost flat
			else 
			{	
				Ysp     = 0;
				Inertia = Xsp;	
			}

			// Adhere to the surface, inherit floor angle and land
			PosY	+= FloorDistance;
			Angle    = FloorAngle;
			Grounded = true;
		}
	}
}