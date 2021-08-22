function PlayerGroundFloorCollision()
{	
	// Exit if collisions are disabled or we are standing on the object
	if !AllowCollision or OnObject
	{
		exit;
	}
	
	// Get current angle quadrant
	if Angle <= 45 or Angle >= 315
	{
		var AngleQuad = QuadFloor;
	}
	else if Angle >= 46.41 and Angle <= 133.59
	{
		var AngleQuad = QuadRWall;
	}
	else if Angle >= 135 and Angle <= 225
	{
		var AngleQuad = QuadRoof;
	}
	else if Angle >= 226.41 and Angle <= 313.59
	{
		var AngleQuad = QuadLWall;
	}	
	switch AngleQuad
	{
		case QuadFloor:
		{		
			// Get nearest tile below us
			var TileLeft  = tile_check_collision_v(PosX - RadiusX, PosY + RadiusY, true, false, Layer);
			var TileRight = tile_check_collision_v(PosX + RadiusX, PosY + RadiusY, true, false, Layer);
			
			// Check if we should use tile right below our position to avoid stupid quirk from originals
			var TileMiddle = tile_check_collision_v(PosX, PosY + RadiusY, true, false, Layer);
			
			// Get data
			if TileMiddle[0] < TileLeft[0] and TileMiddle[0] < TileRight[0]
			{
				var FloorDistance = TileMiddle[0];
				var FloorAngle    = TileMiddle[1];
			}
			else
			{
				var NearestTile   = tile_check_nearest(TileLeft, TileRight, Angle);
				var FloorDistance = NearestTile[0];
				var FloorAngle    = NearestTile[1];
			}
			
			// Go airborne if surface is too far away from us
			if !StickToConvex
			{
				var Distance = Game.S2FloorCollision ? min(4 + abs(floor(Xsp)), 14) : 14;
				if  FloorDistance > Distance
				{
					Grounded = false;
					exit;
				}		
			}
			
			// Else collide
			if FloorDistance >= -14
			{
				PosY += FloorDistance;
				Angle = FloorAngle;	
			}
		}
		break;
		case QuadRWall:
		{	
			// Get nearest tile to our right
			var TileLeft  = tile_check_collision_h(PosX + RadiusY, PosY + RadiusX, true, false, Layer);
			var TileRight = tile_check_collision_h(PosX + RadiusY, PosY - RadiusX, true, false, Layer);
			
			// Get data
			var NearestTile   = tile_check_nearest(TileLeft, TileRight, Angle);
			var FloorDistance = NearestTile[0];
			var FloorAngle    = NearestTile[1];
			
			// Go airborne if surface is too far away from us
			if !StickToConvex
			{
				var Distance = Game.S2FloorCollision ? min(4 + abs(floor(Ysp)), 14) : 14;
				if  FloorDistance > Distance
				{
					Grounded = false;
					exit;
				}	
			}
			
			// Else collide
			if FloorDistance >= -14
			{
				Angle = FloorAngle;
				PosX += FloorDistance;
			}
		}
		break;
		case QuadRoof:	
		{	
			// Get nearest tile above us
			var TileLeft    = tile_check_collision_v(PosX + RadiusX, PosY - RadiusY, false, false, Layer);
			var TileRight   = tile_check_collision_v(PosX - RadiusX, PosY - RadiusY, false, false, Layer);
			
			// Get data
			var NearestTile   = tile_check_nearest(TileLeft, TileRight, Angle);
			var FloorDistance = NearestTile[0];
			var FloorAngle    = NearestTile[1];
			
			// Go airborne if surface is too far away from us
			if !StickToConvex
			{
				var Distance = Game.S2FloorCollision ? min(4 + abs(floor(Xsp)), 14) : 14;
				if  FloorDistance > Distance
				{
					Grounded = false;
					exit;
				}
			}
			
			// Else collide
			if FloorDistance >= -14
			{
				Angle = FloorAngle;
				PosY -= FloorDistance;
			}
		}
		break;
			
		// Handle left wall collision
		case QuadLWall:
		{	
			// Get nearest tile to our left
			var TileLeft  = tile_check_collision_h(PosX - RadiusY, PosY - RadiusX, false, false, Layer);
			var TileRight = tile_check_collision_h(PosX - RadiusY, PosY + RadiusX, false, false, Layer);
			
			// Get data
			var NearestTile   = tile_check_nearest(TileLeft, TileRight, Angle);
			var FloorDistance = NearestTile[0];
			var FloorAngle    = NearestTile[1];
			
			// Go airborne if surface is too far away from us
			if !StickToConvex
			{
				var Distance = Game.S2FloorCollision ? min(4 + abs(floor(Ysp)), 14) : 14;
				if  FloorDistance > Distance
				{
					Grounded = false;
					exit;
				}
			}
				
			// Else collide
		    if FloorDistance >= -14
			{
				Angle = FloorAngle;
				PosX -= FloorDistance;
			}
		}
		break;
	}
}
