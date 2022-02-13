function PlayerGroundFloorCollision()
{	
	if !AllowCollision or OnObject
	{
		return;
	}
	
	// Update floor collision mode
	#region Code
	{
		// Get current angle quadrant (floor and ceiling are in priority, comparing to wall collision)
		if !global.BetterPlayerTileGrip
		{
			if Angle <= 45 or Angle >= 315
			{
				CollisionMode[0] = 0;
			}
			else if Angle >= 46.41 and Angle <= 133.59
			{
				CollisionMode[0] = 1;
			}
			else if Angle >= 135 and Angle <= 225
			{
				CollisionMode[0] = 2;
			}
			else if Angle >= 226.41 and Angle <= 313.59
			{
				CollisionMode[0] = 3;
			}
		}
	
		// ...or update collision mode using a custom method
		else if !CollisionMode[1]
		{
			switch CollisionMode[0]
			{
				case 0:
				{
					var FindTile = tile_find_h(PosX + RadiusY, PosY + RadiusX, true, false, Layer);
					if  FindTile[0] < 0
					{
						if FindTile[1] - Angle mod 360 < 45
						{
							CollisionMode[0] = 1;
						}
					}
			
					var FindTile = tile_find_h(PosX - RadiusY, PosY + RadiusX, false, false, Layer);
					if  FindTile[0] < 0
					{
						if Angle - FindTile[1] < 45
						{
							CollisionMode[0] = 3;
						}
					}
				}
				break;
				case 1:	
				{
					var FindTile = tile_find_v(PosX + RadiusX, PosY + RadiusY, true, false, Layer);
					if  FindTile[0] < 0
					{
						if Angle - FindTile[1] mod 360 < 45
						{
							CollisionMode[0] = 0;
						}
					}
			
					var FindTile = tile_find_v(PosX + RadiusX, PosY - RadiusY, false, false, Layer);
					if  FindTile[0] < 0
					{
						if FindTile[1] - Angle < 45
						{
							CollisionMode[0] = 2;
						}
					}
				}
				break;
				case 2:
				{
					var FindTile = tile_find_h(PosX + RadiusY, PosY - RadiusX, true, false, Layer);
					if  FindTile[0] < 0
					{
						if Angle - FindTile[1] < 45
						{
							CollisionMode[0] = 1;
						}
					}
			
					var FindTile = tile_find_h(PosX - RadiusY, PosY - RadiusX, false, false, Layer);
					if  FindTile[0] < 0
					{
						if FindTile[1] - Angle < 45
						{
							CollisionMode[0] = 3;
						}
					}
				}
				break;
				case 3:
				{
					var FindTile = tile_find_v(PosX - RadiusX, PosY + RadiusY, true, false, Layer);
					if  FindTile[0] < 0
					{
						if FindTile[1] - Angle < 45
						{
							CollisionMode[0] = 0;
						}
					}
			
					var FindTile = tile_find_v(PosX - RadiusX, PosY - RadiusY, false, false, Layer);
					if  FindTile[0] < 0
					{
						if Angle - FindTile[1] < 45
						{
							CollisionMode[0] = 2;
						}
					}
				}
				break;
			}
		}
		else
		{
			CollisionMode[1] = false;
		}
	}
	#endregion
	
	// Perform collision!
	switch CollisionMode[0]
	{
		case 0:
		{		
			// Get tile below us
			var FindFloor = tile_find_2v(PosX - RadiusX, PosY + RadiusY, PosX + RadiusX, PosY + RadiusY, true, false, Angle, Layer);
			
			// Go airborne if surface is too far away from us
			if !StickToConvex
			{
				var Distance = global.S1FloorCollision ? 14 : min(4 + abs(floor(Xsp)), 14);
				if  FindFloor[0] > Distance
				{
					if Animation == AnimMove
					{
						animation_reset(0);
					}
					Pushing  = false;
					Grounded = false;
					
					break;
				}		
			}
			
			// Else collide
			if FindFloor[0] >= -14
			{
				PosY += FindFloor[0];
				Angle = FindFloor[1];	
			}
		}
		break;
		case 1:
		{	
			// Get tile to our right
			var FindFloor = tile_find_2h(PosX + RadiusY, PosY + RadiusX, PosX + RadiusY, PosY - RadiusX, true, false, Angle, Layer);
			
			// Go airborne if surface is too far away from us
			if !StickToConvex
			{
				var Distance = global.S1FloorCollision ? 14 : min(4 + abs(floor(Ysp)), 14);
				if  FindFloor[0] > Distance
				{
					if Animation == AnimMove
					{
						animation_reset(0);
					}
					Pushing  = false;
					Grounded = false;
					
					break;
				}	
			}
			
			// Else collide
			if FindFloor[0] >= -14
			{
				PosX += FindFloor[0];
				Angle = FindFloor[1];	
			}
		}
		break;
		case 2:	
		{	
			// Get tile above us
			var FindFloor = tile_find_2v(PosX + RadiusX, PosY - RadiusY, PosX - RadiusX, PosY - RadiusY, false, false, Angle, Layer);
			
			// Go airborne if surface is too far away from us
			if !StickToConvex
			{
				var Distance = global.S1FloorCollision ? 14 : min(4 + abs(floor(Xsp)), 14);
				if  FindFloor[0] > Distance
				{
					if Animation == AnimMove
					{
						animation_reset(0);
					}
					Pushing  = false;
					Grounded = false;
					
					break;
				}
			}
			
			// Else collide
			if FindFloor[0] >= -14
			{	
				PosY -= FindFloor[0];
				Angle = FindFloor[1];
			}
		}
		break;
		case 3:
		{	
			// Get tile to our left
			var FindFloor = tile_find_2h(PosX - RadiusY, PosY - RadiusX, PosX - RadiusY, PosY + RadiusX, false, false, Angle, Layer); 
			
			// Go airborne if surface is too far away from us
			if !StickToConvex
			{
				var Distance = global.S1FloorCollision ? 14 : min(4 + abs(floor(Ysp)), 14);
				if  FindFloor[0] > Distance
				{
					if Animation == AnimMove
					{
						animation_reset(0);
					}
					Pushing  = false;
					Grounded = false;
					
					break;
				}
			}
				
			// Else collide
		    if FindFloor[0] >= -14
			{
				PosX -= FindFloor[0];
				Angle = FindFloor[1];
			}
		}
		break;
	}
}