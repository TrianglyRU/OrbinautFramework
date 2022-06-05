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
	
	var YOffset = 8 * (Angle == 360);
	var WRadius = DefaultRadiusX + 1;
	
	/* Get current angle quadrant, different from the one used for CollisionMode to define the check direction. 
	The game still uses CollisionMode angle ranges to decide to which side player should be pushed to */
	
	if Angle <= 43.59 or Angle >= 316.41			
	{
		var DirectionCheck = 0;
	}
	else if Angle >= 45 and Angle <= 135	
	{
		var DirectionCheck = 1;
	}
	else if Angle >= 136.41 and Angle <= 223.59
	{
		var DirectionCheck = 2;
	}
	else if Angle >= 225 and Angle <= 315	
	{
		var DirectionCheck = 3;
	}

	// Left wall collision
	if Gsp < 0
	{
		// Check for the wall to our left, frame ahead
		switch DirectionCheck
		{
			case 0:
				var FindWall = tile_find_h(PosX + Xsp - WRadius, PosY + Ysp + YOffset, false, Layer)[0];
			break;
			case 1:
				var FindWall = tile_find_v(PosX + Xsp, PosY + Ysp + WRadius, true, Layer)[0];
			break;
			case 2:
				var FindWall = tile_find_h(PosX + Xsp + WRadius, PosY + Ysp, true, Layer)[0];
			break;
			case 3:
				var FindWall = tile_find_v(PosX + Xsp, PosY + Ysp - WRadius, false, Layer)[0];
			break;
		}
		
		// Collide with it
		if FindWall < 0 then switch CollisionMode[0]
		{
			case 0:
			{
				Xsp -= FindWall;
				Gsp  = 0;
					
				// Set pushing flag
				if Facing == FlipLeft and !Spinning
				{
					Pushing = true;
				}
			}
			break;
			case 1:
			{
				Ysp += FindWall;
			}
			break;
			case 2:
			{
				Xsp += FindWall;
				Gsp  = 0;
					
				// Set pushing flag
				if Facing == FlipLeft and !Spinning
				{
					Pushing = true;
				}
			}
			break;
			case 3:
			{
				Ysp -= FindWall;
			}
			break;
		}
	}
	
	// Right wall collision
	else if Gsp > 0
	{
		// Check for the wall to our right, frame ahead
		switch DirectionCheck
		{
			case 0:
				var FindWall = tile_find_h(PosX + Xsp + WRadius, PosY + Ysp + YOffset, true, Layer)[0];
			break;
			case 1:
				var FindWall = tile_find_v(PosX + Xsp, PosY + Ysp - WRadius, false, Layer)[0];
			break;
			case 2:	
				var FindWall = tile_find_h(PosX + Xsp - WRadius, PosY + Ysp, false, Layer)[0];
			break;
			case 3:
				var FindWall = tile_find_v(PosX + Xsp, PosY + Ysp + WRadius, true, Layer)[0];
			break;
		}
		
		// Collide with it
		if FindWall < 0 then switch CollisionMode[0]
		{
			case 0:
			{
				Xsp += FindWall;
				Gsp  = 0;
					
				// Set pushing flag
				if Facing == FlipRight and !Spinning
				{
					Pushing = true;
				}
			}
			break;
			case 1:
			{
				Ysp -= FindWall;
			}
			break;
			case 2:
			{
				Xsp -= FindWall;
				Gsp  = 0;
				
				// Set pushing flag
				if Facing == FlipRight and !Spinning
				{
					Pushing = true;
				}
			}
			break;
			case 3:
			{
				Ysp += FindWall;
			}
			break;
		}
	}
}