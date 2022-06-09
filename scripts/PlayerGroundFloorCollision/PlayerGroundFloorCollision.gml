function PlayerGroundFloorCollision()
{	
	if !AllowCollision or OnObject
	{
		return;
	}
	
	// Update collision mode
	#region Code
	{
		/* Originals method, get current angle quadrant */

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
	
		/* Custom method, check for slopes. Provides better stability on convex ones */
		
		else if !CollisionMode[1]
		{
			// If the difference between found angle and current angle is greater than this, collision mode won't update
			var AngleTolerance = 45;
			
			switch CollisionMode[0]
			{
				// Floor mode
				case 0:
				{
					// Switch to right wall mode
					var FindTile = tile_find_h(PosX + RadiusY - 2, PosY + RadiusX, true, Layer);
					if  FindTile[0] < 0
					{
						if FindTile[1] - Angle mod 360 < AngleTolerance
						{
							CollisionMode[0] = 1;
						}
					}
					
					// Switch to left wall mode
					var FindTile = tile_find_h(PosX - RadiusY + 2, PosY + RadiusX, false, Layer);
					if  FindTile[0] < 0
					{
						if Angle - FindTile[1] < AngleTolerance
						{
							CollisionMode[0] = 3;
						}
					}
				}
				break;
				
				// Right wall mode
				case 1:	
				{
					// Switch to floor mode
					var FindTile = tile_find_v(PosX + RadiusX, PosY + RadiusY - 2, true, Layer);
					if  FindTile[0] < 0
					{
						if Angle - FindTile[1] mod 360 < AngleTolerance
						{
							CollisionMode[0] = 0;
						}
					}
					
					// Switch to ceiling mode
					var FindTile = tile_find_v(PosX + RadiusX, PosY - RadiusY + 2, false, Layer);
					if  FindTile[0] < 0
					{
						if FindTile[1] - Angle < AngleTolerance
						{
							CollisionMode[0] = 2;
						}
					}
				}
				break;
				
				// Ceiling mode
				case 2:
				{
					// Switch to right wall mode
					var FindTile = tile_find_h(PosX + RadiusY - 2, PosY - RadiusX, true, Layer);
					if  FindTile[0] < 0
					{
						if Angle - FindTile[1] < AngleTolerance
						{
							CollisionMode[0] = 1;
						}
					}
					
					// Switch to left wall mode
					var FindTile = tile_find_h(PosX - RadiusY + 2, PosY - RadiusX, false, Layer);
					if  FindTile[0] < 0
					{
						if FindTile[1] - Angle < AngleTolerance
						{
							CollisionMode[0] = 3;
						}
					}
				}
				break;
				
				// Left wall mode
				case 3:
				{
					// Switch to floor mode
					var FindTile = tile_find_v(PosX - RadiusX, PosY + RadiusY - 2, true, Layer);
					if  FindTile[0] < 0
					{
						if FindTile[1] - Angle < AngleTolerance
						{
							CollisionMode[0] = 0;
						}
					}
					
					// Switch to ceiling mode
					var FindTile = tile_find_v(PosX - RadiusX, PosY - RadiusY + 2, false, Layer);
					if  FindTile[0] < 0
					{
						if Angle - FindTile[1] < AngleTolerance
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
			// Reset landing flag
			CollisionMode[1] = false;
		}
	}
	#endregion
	
	// Perform collision based on current collision mode
	switch CollisionMode[0]
	{
		// Floor mode
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
		
		// Right wall mode
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
		
		// Ceiling mode
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
		
		// Left wall mode
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