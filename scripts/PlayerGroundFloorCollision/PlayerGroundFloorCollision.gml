function PlayerGroundFloorCollision()
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
			var TileLeft   = tile_check_collision_v(floor(PosX - RadiusX), floor(PosY + RadiusY), true, false, Layer);
			var TileRight  = tile_check_collision_v(floor(PosX + RadiusX), floor(PosY + RadiusY), true, false, Layer);
			
			// Get nearest tile
			var NearestTile = tile_check_nearest(TileLeft, TileRight, Angle);
			
			// Get data
			var FloorDistance = NearestTile[0];
			var FloorAngle    = NearestTile[1];
			
			// Lose ground if the surface below us is too far away
			if !StickToConvex
			{
				var Distance = Game.SpeedFloorClip ? min(4 + abs(floor(Xsp)), 14) : 14;
				if  FloorDistance > Distance
				{
					Grounded = false;
					break;
				}		
			}
				
			// Else adhere to the surface and inherit the floor angle
			if FloorDistance >= -14
			{
				PosY += FloorDistance;
				Angle = FloorAngle;	
			}
		}
		break;
			
		// Handle right wall collision
		case RangeRWall:
		{	
			// Get the tiles to our right
			var TileLeft  = tile_check_collision_h(floor(PosX + RadiusY), floor(PosY + RadiusX), true, false, Layer);
			var TileRight = tile_check_collision_h(floor(PosX + RadiusY), floor(PosY - RadiusX), true, false, Layer);
			
			// Get nearest tile
			var NearestTile = tile_check_nearest(TileLeft, TileRight, Angle);
			
			// Get data
			var FloorDistance = NearestTile[0];
			var FloorAngle    = NearestTile[1];
			
			// Go airborne if the surface is far to the right from us
			if !StickToConvex
			{
				var Distance = Game.SpeedFloorClip ? min(4 + abs(floor(Ysp)), 14) : 14;
				if  FloorDistance > Distance
				{
					Grounded = false;
					break;
				}	
			}
				
			// Else adhere to the surface and inherit the floor angle
			if FloorDistance >= -14
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
			var TileLeft  = tile_check_collision_v(floor(PosX + RadiusX), floor(PosY - RadiusY), false, false, Layer);
			var TileRight = tile_check_collision_v(floor(PosX - RadiusX), floor(PosY - RadiusY), false, false, Layer);
			
			// Get nearest tile
			var NearestTile = tile_check_nearest(TileLeft, TileRight, Angle);
			
			// Get data
			var FloorDistance = NearestTile[0];
			var FloorAngle    = NearestTile[1];
			
			// Go airborne if the surface above us is too far away
			if !StickToConvex
			{
				var Distance = Game.SpeedFloorClip ? min(4 + abs(floor(Xsp)), 14) : 14;
				if  FloorDistance > Distance
				{
					Grounded = false;
					break;
				}
			}
				
			// Else adhere to the surface and inherit the floor angle
			if FloorDistance >= -14
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
			var TileLeft  = tile_check_collision_h(floor(PosX - RadiusY), floor(PosY - RadiusX), false, false, Layer);
			var TileRight = tile_check_collision_h(floor(PosX - RadiusY), floor(PosY + RadiusX), false, false, Layer);
			
			// Get nearest tile
			var NearestTile = tile_check_nearest(TileLeft, TileRight, Angle);
			
			// Get data
			var FloorDistance = NearestTile[0];
			var FloorAngle    = NearestTile[1];
			
			// Go airborne if the surface is far to the left from us
			if !StickToConvex
			{
				var Distance = Game.SpeedFloorClip ? min(4 + abs(floor(Ysp)), 14) : 14;
				if  FloorDistance > Distance
				{
					Grounded = false;
					break;
				}
			}
				
			// Else adhere to the surface and inherit the floor angle
		    if FloorDistance >= -14
			{
				Angle = FloorAngle;
				PosX -= FloorDistance;
			}
		}
		break;
	}
}
