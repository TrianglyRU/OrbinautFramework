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
	
	// Use different from floor collision angle ranges if custom collision is disabled
	if Angle <= 43.59 or Angle >= 316.41			
	{
		var CollisionMode = 0;
	}
	else if Angle >= 45 and Angle <= 135	
	{
		var CollisionMode = 1;
	}
	else if Angle >= 136.41 and Angle <= 223.59
	{
		var CollisionMode = 2;
	}
	else if Angle >= 225 and Angle <= 315	
	{
		var CollisionMode = 3;
	}
	
	// Collide with the wall to our left, frame ahead
	if Inertia < 0
	{
		switch CollisionMode
		{
			case 0:
			{	
				// Lower wall sensors by 8 pixels on a flat floor
				var YOffset = 8 * (Angle == 360);
				
				var Distance = tile_check_collision_h(PosX + Xsp - RadiusW, PosY + Ysp + YOffset, false, true, Layer)[0];
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
			case 1:
			{
				var Distance = tile_check_collision_v(PosX + Xsp, PosY + Ysp + RadiusW, true, true, Layer)[0];
				if  Distance < 0
				{
					// Affect player speeds
					Ysp    += Distance;
					Inertia = 0;
				}
			}
			break;
			case 2:
			{	
				var Distance = tile_check_collision_h(PosX + Xsp + RadiusW, PosY + Ysp, true, true, Layer)[0];
				if  Distance < 0
				{	
					// Affect player speeds
					Xsp    += Distance;
					Inertia = 0;
				}
			}
			break;
			case 3:
			{
				var Distance = tile_check_collision_v(PosX + Xsp, PosY + Ysp - RadiusW, false, true, Layer)[0];
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
		switch CollisionMode
		{
			case 0:
			{	
				var Distance = tile_check_collision_h(PosX + Xsp + RadiusW, PosY + Ysp + 8 * (Angle == 360), true, true, Layer)[0];
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
			case 1:
			{
				var Distance = tile_check_collision_v(PosX + Xsp, PosY + Ysp - RadiusW, false, true, Layer)[0];
				if  Distance < 0
				{	
					// Affect player speeds
					Ysp    -= Distance;
					Inertia = 0;
				}
			}
			break;
			case 2:
			{	
				var Distance = tile_check_collision_h(PosX + Xsp - RadiusW, PosY + Ysp, false, true, Layer)[0];
				if  Distance < 0
				{	
					// Affect player speeds
					Xsp    -= Distance;
					Inertia = 0;
				}
			}
			break;
			case 3:
			{
				var Distance = tile_check_collision_v(PosX + Xsp, PosY + Ysp + RadiusW, true, true, Layer)[0];
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