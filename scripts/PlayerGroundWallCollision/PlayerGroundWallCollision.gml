function PlayerGroundWallCollision()
{	
	// Exit if collision are disabled
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
	
	// Get current angle quadrant
	if Angle <= 43.59 or Angle >= 316.41			
	{
		var AngleQuad = QuadFloor;
	}
	else if Angle >= 45 and Angle <= 135	
	{
		var AngleQuad = QuadRWall;
	}
	else if Angle >= 136.41 and Angle <= 223.59
	{
		var AngleQuad = QuadRoof;
	}
	else if Angle >= 225 and Angle <= 315	
	{
		var AngleQuad = QuadLWall;
	}
	
	// Collide with the wall to our left, frame ahead
	if Inertia < 0
	{
		switch AngleQuad
		{
			case QuadFloor:
			{	
				// Lower wall sensors by 8 pixels on a flat floor
				var YOffset  = 8 * (Angle == 360);
				
				var Distance = tile_check_collision_h(PosX + Xsp - 10, PosY + Ysp + YOffset, false, true, Layer)[0];
				if  Distance < 0 
				{	
					// Affect player speeds
					Xsp    -= Distance;
					Inertia = 0;
					
					// Set pushing flag
					if Facing == FlipLeft
					{
						Pushing = true;
					}
				}
			}
			break;
			case QuadRWall:
			{
				var Distance = tile_check_collision_v(PosX + Xsp, PosY + Ysp + 10, true, true, Layer)[0];
				if  Distance < 0
				{
					// Affect player speeds
					Ysp    += Distance;
					Inertia = 0;
				}
			}
			break;
			case QuadRoof:
			{	
				var Distance = tile_check_collision_h(PosX + Xsp + 10, PosY + Ysp, true, true, Layer)[0];
				if  Distance < 0
				{	
					// Affect player speeds
					Xsp    += Distance;
					Inertia = 0;
				}
			}
			break;
			case QuadLWall:
			{
				var Distance = tile_check_collision_v(PosX + Xsp, PosY + Ysp - 10, false, true, Layer)[0];
				if  Distance < 0
				{	
					// Affect player speeds
					Ysp    -= Distance;
					Inertia = 0;
				}
			}
			break;
		}
	}
	
	// Collide with the wall to our right, frame ahead
	else if Inertia > 0
	{
		switch AngleQuad
		{
			case QuadFloor:
			{	
				var Distance = tile_check_collision_h(PosX + Xsp + 10, PosY + Ysp + 8 * (Angle == 360), true, true, Layer)[0];
				if  Distance < 0
				{	
					// Affect player speeds
					Xsp    += Distance;
					Inertia = 0;
					
					// Set pushing flag
					if Facing == FlipRight
					{
						Pushing = true;
					}
				}
			}
			break;
			case QuadRWall:
			{
				var Distance = tile_check_collision_v(PosX + Xsp, PosY + Ysp - 10, false, true, Layer)[0];
				if  Distance < 0
				{	
					// Affect player speeds
					Ysp    -= Distance;
					Inertia = 0;
				}
			}
			break;
			case QuadRoof:
			{	
				var Distance = tile_check_collision_h(PosX + Xsp - 10, PosY + Ysp, false, true, Layer)[0];
				if  Distance < 0
				{	
					// Affect player speeds
					Xsp    -= Distance;
					Inertia = 0;
				}
			}
			break;
			case QuadLWall:
			{
				var Distance = tile_check_collision_v(PosX + Xsp, PosY + Ysp + 10, true, true, Layer)[0];
				if  Distance < 0
				{	
					// Affect player speeds
					Ysp    += Distance;
					Inertia = 0;
				}
			}
			break;
		}
	}
}