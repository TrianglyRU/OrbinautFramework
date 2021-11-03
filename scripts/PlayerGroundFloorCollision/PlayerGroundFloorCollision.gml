function PlayerGroundFloorCollision()
{	
	// Exit if collisions are disabled or we are standing on the object
	if !AllowCollision or OnObject
	{
		exit;
	}
	
	// Get current angle quadrant normally, like in originals
	if Angle <= 45 or Angle >= 315
	{
		var CollisionMode = 0;
	}
	else if Angle >= 46.41 and Angle <= 133.59
	{
		var CollisionMode = 1;
	}
	else if Angle >= 135 and Angle <= 225
	{
		var CollisionMode = 2;
	}
	else if Angle >= 226.41 and Angle <= 313.59
	{
		var CollisionMode = 3;
	}
	
	// Collide with floor
	switch CollisionMode
	{
		case 0:
		{		
			// Get nearest tile below us
			var TileLeft    = tile_check_collision_v(PosX - RadiusX, PosY + RadiusY, true, false, Layer);
			var TileRight   = tile_check_collision_v(PosX + RadiusX, PosY + RadiusY, true, false, Layer);
		    var NearestTile = tile_check_nearest(TileLeft, TileRight, Angle);
				
			// Get data
			var FloorDistance = NearestTile[0];
			var FloorAngle    = NearestTile[1];
			
			// Go airborne if surface is too far away from us
			if !StickToConvex
			{
				var Distance = Game.S2FloorCollision ? min(4 + abs(floor(Xsp)), 14) : 14;
				if  FloorDistance > Distance
				{
					// Restart animation...?
					animation_reset(0);
					
					Pushing  = false;
					Grounded = false;
					break;
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
		case 1:
		{	
			// Get nearest tile to our right
			var TileLeft    = tile_check_collision_h(PosX + RadiusY, PosY + RadiusX, true, false, Layer);
			var TileRight   = tile_check_collision_h(PosX + RadiusY, PosY - RadiusX, true, false, Layer);
			var NearestTile = tile_check_nearest(TileLeft, TileRight, Angle);
			
			// Get data
			var FloorDistance = NearestTile[0];
			var FloorAngle    = NearestTile[1];
			
			// Go airborne if surface is too far away from us
			if !StickToConvex
			{
				var Distance = Game.S2FloorCollision ? min(4 + abs(floor(Ysp)), 14) : 14;
				if  FloorDistance > Distance
				{
					// Restart animation...?
					animation_reset(0);
					
					Pushing  = false;
					Grounded = false;
					break;
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
		case 2:	
		{	
			// Get nearest tile above us
			var TileLeft    = tile_check_collision_v(PosX + RadiusX, PosY - RadiusY, false, false, Layer);
			var TileRight   = tile_check_collision_v(PosX - RadiusX, PosY - RadiusY, false, false, Layer);
			var NearestTile = tile_check_nearest(TileLeft, TileRight, Angle);
			
			// Get data
			var FloorDistance = NearestTile[0];
			var FloorAngle    = NearestTile[1];
			
			// Go airborne if surface is too far away from us
			if !StickToConvex
			{
				var Distance = Game.S2FloorCollision ? min(4 + abs(floor(Xsp)), 14) : 14;
				if  FloorDistance > Distance
				{
					// Restart animation...?
					animation_reset(0);
					
					Pushing  = false;
					Grounded = false;
					break;
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
		case 3:
		{	
			// Get nearest tile to our left
			var TileLeft    = tile_check_collision_h(PosX - RadiusY, PosY - RadiusX, false, false, Layer);
			var TileRight   = tile_check_collision_h(PosX - RadiusY, PosY + RadiusX, false, false, Layer);
			var NearestTile = tile_check_nearest(TileLeft, TileRight, Angle);
			
			// Get data
			var FloorDistance = NearestTile[0];
			var FloorAngle    = NearestTile[1];
			
			// Go airborne if surface is too far away from us
			if !StickToConvex
			{
				var Distance = Game.S2FloorCollision ? min(4 + abs(floor(Ysp)), 14) : 14;
				if  FloorDistance > Distance
				{
					// Restart animation...?
					animation_reset(0);
					
					Pushing  = false;
					Grounded = false;
					break;
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