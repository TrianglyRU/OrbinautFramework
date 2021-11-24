function PlayerGroundWallCollision()
{	
	// Exit if collisions are disabled
	if !AllowCollision
	{
		exit;
	}
	
	// Exit if angle is too steep or not a cardinal one
	if Angle >= 90 and Angle <= 270
	{
		if !Game.SKWallCollision or Angle mod 90 != 0
		{
			exit;
		}
	}
	
	// Get current angle quadrant (shallower on walls, comparing to ground collision)
	if Angle <= 43.59 or Angle >= 316.41			
	{
		var Mode = 0;
	}
	else if Angle >= 45 and Angle <= 135	
	{
		var Mode = 1;
	}
	else if Angle >= 136.41 and Angle <= 223.59
	{
		var Mode = 2;
	}
	else if Angle >= 225 and Angle <= 315	
	{
		var Mode = 3;
	}
	
	// Collide with the wall to our left, frame ahead
	if Inertia < 0
	{
		switch Mode
		{
			case 0:
			{	
				// Lower wall sensors by 8 pixels on a flat floor
				var YOffset = 8 * (Angle == 360);
				
				var FindWall = tile_find_h(PosX + Xsp - RadiusW, PosY + Ysp + YOffset, false, true, Layer)[0];
				if  FindWall < 0 
				{	
					Xsp    -= FindWall;
					Inertia = 0;
					
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
				var FindWall = tile_find_v(PosX + Xsp, PosY + Ysp + RadiusW, true, true, Layer)[0];
				if  FindWall < 0
				{
					Ysp    += FindWall;
					Inertia = 0;
				}
			}
			break;
			case 2:
			{	
				var FindWall = tile_find_h(PosX + Xsp + RadiusW, PosY + Ysp, true, true, Layer)[0];
				if  FindWall < 0
				{	
					Xsp    += FindWall;
					Inertia = 0;
				}
			}
			break;
			case 3:
			{
				var FindWall = tile_find_v(PosX + Xsp, PosY + Ysp - RadiusW, false, true, Layer)[0];
				if  FindWall < 0
				{	
					Ysp    -= FindWall;
					Inertia = 0;
				}
			}
			break;
		}
	}
	
	// Collide with the wall to our right, frame ahead
	else if Inertia > 0
	{
		switch Mode
		{
			case 0:
			{	
				var FindWall = tile_find_h(PosX + Xsp + RadiusW, PosY + Ysp + 8 * (Angle == 360), true, true, Layer)[0];
				if  FindWall < 0
				{	
					Xsp    += FindWall;
					Inertia = 0;
					
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
				var FindWall = tile_find_v(PosX + Xsp, PosY + Ysp - RadiusW, false, true, Layer)[0];
				if  FindWall < 0
				{	
					Ysp    -= FindWall;
					Inertia = 0;
				}
			}
			break;
			case 2:
			{	
				var FindWall = tile_find_h(PosX + Xsp - RadiusW, PosY + Ysp, false, true, Layer)[0];
				if  FindWall < 0
				{	
					Xsp    -= FindWall;
					Inertia = 0;
				}
			}
			break;
			case 3:
			{
				var FindWall = tile_find_v(PosX + Xsp, PosY + Ysp + RadiusW, true, true, Layer)[0];
				if  FindWall < 0
				{	
					Ysp    += FindWall;
					Inertia = 0;
				}
			}
			break;
		}
	}
}