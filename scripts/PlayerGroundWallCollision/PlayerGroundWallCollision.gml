function PlayerGroundWallCollision()
{	
	if !AllowCollision
	{
		return;
	}
	
	// Unsymmetric check here!
	if Angle >= 91.41 and Angle <= 270
	{
		if !global.SKWallCollision or Angle mod 90 != 0
		{
			return;
		}
	}
	
	// Get current angle quadrant (walls are in priority, comparing to default ground collision)
	if Angle <= 43.59 or Angle >= 316.41			
	{
		WallMode = 0;
	}
	else if Angle >= 45 and Angle <= 135	
	{
		WallMode = 1;
	}
	else if Angle >= 136.41 and Angle <= 223.59
	{
		WallMode = 2;
	}
	else if Angle >= 225 and Angle <= 315	
	{
		WallMode = 3;
	}
	
	var YOffset = 8 * (Angle == 360);
	var WRadius = DefaultRadiusX + 1;
	
	// Collide with the wall to our left, frame ahead
	if Gsp < 0
	{
		switch WallMode
		{
			case 0:
			{	
				var FindWall = tile_find_h(PosX + Xsp - WRadius, PosY + Ysp + YOffset, false, Layer)[0];
				if  FindWall < 0 
				{	
					Xsp -= FindWall;
					Gsp  = 0;
					
					// Set pushing flag
					if Facing == FlipLeft and !Spinning
					{
						Pushing = true;
					}
				}
			}
			break;
			case 1:
			{
				var FindWall = tile_find_v(PosX + Xsp, PosY + Ysp + WRadius, true, Layer)[0];
				if  FindWall < 0
				{
					Ysp += FindWall;
					Gsp  = 0;
				}
			}
			break;
			case 2:
			{	
				var FindWall = tile_find_h(PosX + Xsp + WRadius, PosY + Ysp, true, Layer)[0];
				if  FindWall < 0
				{	
					Xsp += FindWall;
					Gsp  = 0;
				}
			}
			break;
			case 3:
			{
				var FindWall = tile_find_v(PosX + Xsp, PosY + Ysp - WRadius, false, Layer)[0];
				if  FindWall < 0
				{	
					Ysp -= FindWall;
					Gsp  = 0;
				}
			}
			break;
		}
	}
	
	// Collide with the wall to our right, frame ahead
	else if Gsp > 0
	{
		switch WallMode
		{
			case 0:
			{	
				var FindWall = tile_find_h(PosX + Xsp + WRadius, PosY + Ysp + YOffset, true, Layer)[0];
				if  FindWall < 0
				{	
					Xsp += FindWall;
					Gsp  = 0;
					
					// Set pushing flag
					if Facing == FlipRight and !Spinning
					{
						Pushing = true;
					}
				}
			}
			break;
			case 1:
			{
				var FindWall = tile_find_v(PosX + Xsp, PosY + Ysp - WRadius, false, Layer)[0];
				if  FindWall < 0
				{	
					Ysp -= FindWall;
					Gsp  = 0;
				}
			}
			break;
			case 2:
			{	
				var FindWall = tile_find_h(PosX + Xsp - WRadius, PosY + Ysp, false, Layer)[0];
				if  FindWall < 0
				{	
					Xsp -= FindWall;
					Gsp  = 0;
				}
			}
			break;
			case 3:
			{
				var FindWall = tile_find_v(PosX + Xsp, PosY + Ysp + WRadius, true, Layer)[0];
				if  FindWall < 0
				{	
					Ysp += FindWall;
					Gsp  = 0;
				}
			}
			break;
		}
	}
}