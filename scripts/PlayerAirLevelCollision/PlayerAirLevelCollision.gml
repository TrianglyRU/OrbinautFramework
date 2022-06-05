function PlayerAirLevelCollision()
{
	if !AllowCollision
	{
		return;
	}
	
	var WRadius = DefaultRadiusX + 1;
	
	// Define direction of our movement
	if abs(Xsp) >= abs(Ysp)
	{
		var MoveDirection = Xsp > 0 ? "MoveRight" : "MoveLeft";
	}
	else
	{
		var MoveDirection = Ysp > 0 ? "MoveDown" : "MoveUp";
	}
	
	// Process collision
	switch MoveDirection
	{
		case "MoveDown":
		{
			// Collide with left wall
			var FindWall = tile_find_h(PosX - WRadius, PosY, false, Layer)[0];
			if  FindWall < 0
			{
				PosX -= FindWall;
				Xsp   = 0;
			}
			
			// Collide with right wall
			var FindWall = tile_find_h(PosX + WRadius, PosY, true, Layer)[0];
			if  FindWall < 0
			{
				PosX += FindWall;
				Xsp   = 0;
			}
			
			// Collide with floor. We have to remember both distances, so we do not use tile_find_2v here
			var FindFloor1 = tile_find_v(PosX - RadiusX, PosY + RadiusY, true, Layer);
			var FindFloor2 = tile_find_v(PosX + RadiusX, PosY + RadiusY, true, Layer);
			
			if FindFloor1[0] <= FindFloor2[0]
			{
				var Dist = FindFloor1[0];
				var Ang	 = FindFloor1[1];
			}
			else
			{
				var Dist = FindFloor2[0];
				var Ang	 = FindFloor2[1];
			}
			var ClipCheck = -(Ysp + 8)
			
			if Dist < 0 and (FindFloor1[0] >= ClipCheck or FindFloor2[0] >= ClipCheck)
			{
				if Ang >= 46.41 and Ang <= 315
				{
					if Ysp > 15.75
					{
						Ysp = 15.75;
					}
					Xsp = 0;
					Gsp = Ang < 180 ? -Ysp : Ysp;
				}
				else if Ang >= 23.91 and Ang <= 337.5
				{
					Gsp = Ang < 180 ? -Ysp / 2 : Ysp / 2;
				}
				else 
				{	
					Ysp = 0;
					Gsp = Xsp;	
				}
					
				// Adhere to the surface and land
				PosY    += Dist;
				Angle    = Ang;
				Grounded = true;
			}
		}
		break;	
		case "MoveUp":
		{
			// Collide with left wall
			var FindWall = tile_find_h(PosX - WRadius, PosY, false, Layer)[0];
			if  FindWall < 0
			{
				PosX -= FindWall;
				Xsp   = 0;
			}
			
			// Collide with right wall
			var FindWall = tile_find_h(PosX + WRadius, PosY, true, Layer)[0];
			if  FindWall < 0
			{
				PosX += FindWall;
				Xsp   = 0;
			}
			
			// Collide with ceiling
			var FindRoof = tile_find_2v(PosX - RadiusX, PosY - RadiusY, PosX + RadiusX, PosY - RadiusY, false, noone, Layer);
			if  FindRoof[0] < 0
			{	
				if (FindRoof[1] >= 91.41  and FindRoof[1] <= 136.41 
				or  FindRoof[1] >= 226.41 and FindRoof[1] <= 268.59) and !FlightState
				{
					// Land on it if its angle steep enough
					Angle    = FindRoof[1];
					Gsp      = FindRoof[1] < 180 ? -Ysp : Ysp;
					Grounded = true;
				}
				else 
				{
					if FlightState
					{
						Grv	= 0.03125;
					}	
					Ysp = 0;
				}				
				PosY -= FindRoof[0];
			}
		}
		break;		
		case "MoveLeft":
		{
			// Collide with left wall
			var FindWall = tile_find_h(PosX - WRadius, PosY, false, Layer)[0];
			if  FindWall < 0
			{
				PosX -= FindWall;
				Gsp   = Ysp;
				Xsp   = 0;
			}
			else
			{
				// Collide with ceiling
				var FindRoof = tile_find_2v(PosX - RadiusX, PosY - RadiusY, PosX + RadiusX, PosY - RadiusY, false, noone, Layer);
				if  FindRoof[0] < 0
				{	
					if Ysp < 0
					{
						Ysp = 0;
					}
					if FlightState
					{
						Grv	= 0.03125;
					}
					PosY -= FindRoof[0];
				}
				else if Ysp > 0
				{
					// Collide with floor
					var FindFloor = tile_find_2v(PosX - RadiusX, PosY + RadiusY, PosX + RadiusX, PosY + RadiusY, true, noone, Layer);
					if  FindFloor[0] < 0
					{
						PosY	+= FindFloor[0];
						Angle    = FindFloor[1];
						Gsp		 = Xsp;
						Ysp      = 0;
						Grounded = true;
					}
				}
			}
		}
		break;
		case "MoveRight":
		{
			// Collide with right wall
			var FindWall = tile_find_h(PosX + WRadius, PosY, true, Layer)[0];
			if  FindWall < 0
			{
				PosX += FindWall;
				Gsp   = Ysp;
				Xsp   = 0;	
			}
			else
			{
				// Collide with ceiling
				var FindRoof = tile_find_2v(PosX - RadiusX, PosY - RadiusY, PosX + RadiusX, PosY - RadiusY, false, noone, Layer);
				if  FindRoof[0] < 0
				{	
					if Ysp < 0
					{
						Ysp = 0;
					}
					if FlightState
					{
						Grv	= 0.03125;
					}
					PosY -= FindRoof[0];
				}
				else if Ysp > 0
				{
					// Collide with floor
					var FindFloor = tile_find_2v(PosX - RadiusX, PosY + RadiusY, PosX + RadiusX, PosY + RadiusY, true, noone, Layer);
					if  FindFloor[0] < 0
					{
						PosY	+= FindFloor[0];
						Angle    = FindFloor[1];
						Gsp		 = Xsp
						Ysp      = 0;
						Grounded = true;
					}
				}
			}
		}
		break;
	}
	
	// If landed, update floor mode if using the custom method
	if global.BetterPlayerTileGrip and Grounded
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
		
		// This will disable floor mode check for one frame, allowing us to land on the ceilings safely
		CollisionMode[1] = true;
	}
}