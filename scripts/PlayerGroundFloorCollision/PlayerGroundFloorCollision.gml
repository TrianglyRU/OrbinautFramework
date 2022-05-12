function PlayerGroundFloorCollision()
{	
	if !AllowCollision or OnObject
	{
		return;
	}
	
	// Update floor mode
	#region Code
	{
		// Originals method: get current angle quadrant (floor and ceiling are in priority, comparing to wall collision)
		if !global.BetterPlayerTileGrip
		{
			if Angle <= 45 or Angle >= 315
			{
				FloorMode[0] = 0;
			}
			else if Angle >= 46.41 and Angle <= 133.59
			{
				FloorMode[0] = 1;
			}
			else if Angle >= 135 and Angle <= 225
			{
				FloorMode[0] = 2;
			}
			else if Angle >= 226.41 and Angle <= 313.59
			{
				FloorMode[0] = 3;
			}
		}
	
		// Custom method
		else if !FloorMode[1]
		{
			switch FloorMode[0]
			{
				case 0:
				{
					var FindTile = tile_find_h(PosX + RadiusY, PosY + RadiusX, true, Layer);
					if  FindTile[0] < 0
					{
						if FindTile[1] - Angle mod 360 < 45
						{
							FloorMode[0] = 1;
						}
					}
			
					var FindTile = tile_find_h(PosX - RadiusY, PosY + RadiusX, false, Layer);
					if  FindTile[0] < 0
					{
						if Angle - FindTile[1] < 45
						{
							FloorMode[0] = 3;
						}
					}
				}
				break;
				case 1:	
				{
					var FindTile = tile_find_v(PosX + RadiusX, PosY + RadiusY, true, Layer);
					if  FindTile[0] < 0
					{
						if Angle - FindTile[1] mod 360 < 45
						{
							FloorMode[0] = 0;
						}
					}
			
					var FindTile = tile_find_v(PosX + RadiusX, PosY - RadiusY, false, Layer);
					if  FindTile[0] < 0
					{
						if FindTile[1] - Angle < 45
						{
							FloorMode[0] = 2;
						}
					}
				}
				break;
				case 2:
				{
					var FindTile = tile_find_h(PosX + RadiusY, PosY - RadiusX, true, Layer);
					if  FindTile[0] < 0
					{
						if Angle - FindTile[1] < 45
						{
							FloorMode[0] = 1;
						}
					}
			
					var FindTile = tile_find_h(PosX - RadiusY, PosY - RadiusX, false, Layer);
					if  FindTile[0] < 0
					{
						if FindTile[1] - Angle < 45
						{
							FloorMode[0] = 3;
						}
					}
				}
				break;
				case 3:
				{
					var FindTile = tile_find_v(PosX - RadiusX, PosY + RadiusY, true, Layer);
					if  FindTile[0] < 0
					{
						if FindTile[1] - Angle < 45
						{
							FloorMode[0] = 0;
						}
					}
			
					var FindTile = tile_find_v(PosX - RadiusX, PosY - RadiusY, false, Layer);
					if  FindTile[0] < 0
					{
						if Angle - FindTile[1] < 45
						{
							FloorMode[0] = 2;
						}
					}
				}
				break;
			}
		}
		else
		{
			FloorMode[1] = false;
		}
	}
	#endregion
	
	// Perform collision!
	switch FloorMode[0]
	{
		case 0:
		{		
			// Get tile below us
			var FindFloor = tile_find_2v(PosX - RadiusX, PosY + RadiusY, PosX + RadiusX, PosY + RadiusY, true, Angle, Layer);
			
			// Go airborne if surface is too far away from us
			if !StickToConvex
			{
				var Distance = !global.S2FloorCollision ? 14 : min(4 + abs(floor(Xsp)), 14);
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
			var FindFloor = tile_find_2h(PosX + RadiusY, PosY + RadiusX, PosX + RadiusY, PosY - RadiusX, true, Angle, Layer);
			
			// Go airborne if surface is too far away from us
			if !StickToConvex
			{
				var Distance = !global.S2FloorCollision ? 14 : min(4 + abs(floor(Ysp)), 14);
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
			var FindFloor = tile_find_2v(PosX + RadiusX, PosY - RadiusY, PosX - RadiusX, PosY - RadiusY, false, Angle, Layer);
			
			// Go airborne if surface is too far away from us
			if !StickToConvex
			{
				var Distance = !global.S2FloorCollision ? 14 : min(4 + abs(floor(Xsp)), 14);
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
			var FindFloor = tile_find_2h(PosX - RadiusY, PosY - RadiusX, PosX - RadiusY, PosY + RadiusX, false, Angle, Layer); 
			
			// Go airborne if surface is too far away from us
			if !StickToConvex
			{
				var Distance = !global.S2FloorCollision ? 14 : min(4 + abs(floor(Ysp)), 14);
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