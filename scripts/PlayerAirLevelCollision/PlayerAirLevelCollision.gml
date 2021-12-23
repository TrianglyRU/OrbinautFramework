function PlayerAirLevelCollision()
{
	// Exit if collision is not allowed
	if !AllowCollision or ClimbState or GlideState
	{
		exit;
	}
	
	// Get movement angle quadrant
	if abs(Xsp) >= abs(Ysp)
	{
		var MoveDirection = Xsp > 0 ? "MoveRight" : "MoveLeft";
	}
	else
	{
		var MoveDirection = Ysp > 0 ? "MoveDown" : "MoveUp";
	}
	switch MoveDirection
	{
		case "MoveDown":
		{
			// Collide with left wall
			var FindWall = tile_find_h(PosX - RadiusW, PosY, false, true, Layer)[0];
			if  FindWall < 0
			{
				PosX -= FindWall;
				Xsp   = 0;
			}
			
			// Collide with right wall
			var FindWall = tile_find_h(PosX + RadiusW, PosY, true, true, Layer)[0];
			if  FindWall < 0
			{
				PosX += FindWall;
				Xsp   = 0;
			}
			
			// Collide with floor
			var FindFloor = tile_find_2v(PosX - RadiusX, PosY + RadiusY, PosX + RadiusX, PosY + RadiusY, true, false, noone, Layer);
			if  FindFloor[0] < 0 and FindFloor[0] >= -(Ysp + 8)
			{
				// Convert speed to inertia
				if FindFloor[1] >= 46.41 and FindFloor[1] <= 315
				{
					// Limit ysp
					if Ysp > 15.75
					{
						Ysp = 15.75;
					}
					Xsp		= 0;
					Inertia = FindFloor[1] < 180 ? -Ysp : Ysp;
				}
				else if FindFloor[1] >= 23.91 and FindFloor[1] <= 337.5
				{
					Inertia = FindFloor[1] < 180 ? -Ysp / 2 : Ysp / 2;
				}
				else 
				{	
					Ysp     = 0;
					Inertia = Xsp;	
				}
					
				// Clip out and land
				PosY    += FindFloor[0];
				Angle    = FindFloor[1];
				Grounded = true;
			}
		}
		break;	
		case "MoveUp":
		{
			// Collide with left wall
			var FindWall = tile_find_h(PosX - RadiusW, PosY, false, true, Layer)[0];
			if  FindWall < 0
			{
				PosX -= FindWall;
				Xsp   = 0;
			}
			
			// Collide with right wall
			var FindWall = tile_find_h(PosX + RadiusW, PosY, true, true, Layer)[0];
			if  FindWall < 0
			{
				PosX += FindWall;
				Xsp   = 0;
			}
			
			// Collide with ceiling
			var FindRoof = tile_find_2v(PosX - RadiusX, PosY - RadiusY, PosX + RadiusX, PosY - RadiusY, false, true, noone, Layer);
			if  FindRoof[0] < 0
			{	
				// Land on it if steep enough
				if (FindRoof[1] >= 91.41  and FindRoof[1] <= 136.41 
				or  FindRoof[1] >= 226.41 and FindRoof[1] <= 268.59) and !FlightState
				{
					Angle    = FindRoof[1];
					Inertia  = FindRoof[1] < 180 ? -Ysp : Ysp;
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
			var FindWall = tile_find_h(PosX - RadiusW, PosY, false, true, Layer)[0];
			if  FindWall < 0
			{
				PosX -= FindWall;
				Xsp   = 0;
				
				// Set inertia to... ysp?
				Inertia = Ysp;
			}
			
			// Try ceiling collision
			else
			{
				var FindRoof = tile_find_2v(PosX - RadiusX, PosY - RadiusY, PosX + RadiusX, PosY - RadiusY, false, true, noone, Layer);
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
				
				// Try floor collision
				else if Ysp > 0
				{
					var FindFloor = tile_find_2v(PosX - RadiusX, PosY + RadiusY, PosX + RadiusX, PosY + RadiusY, true, false, noone, Layer);
					if  FindFloor[0] < 0
					{
						PosY	+= FindFloor[0];
						Angle    = FindFloor[1];
						Inertia  = Xsp;
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
			var FindWall = tile_find_h(PosX + RadiusW, PosY, true, true, Layer)[0];
			if  FindWall < 0
			{
				PosX += FindWall;
				Xsp   = 0;
				
				// Also set inertia to... ysp?
				Inertia = Ysp;
			}
			
			// Try ceiling collision
			else
			{
				var FindRoof = tile_find_2v(PosX - RadiusX, PosY - RadiusY, PosX + RadiusX, PosY - RadiusY, false, true, noone, Layer);
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
				
				// Try floor collision
				else if Ysp > 0
				{
					var FindFloor = tile_find_2v(PosX - RadiusX, PosY + RadiusY, PosX + RadiusX, PosY + RadiusY, true, false, noone, Layer);
					if  FindFloor[0] < 0
					{
						PosY	+= FindFloor[0];
						Angle    = FindFloor[1];
						Inertia  = Xsp
						Ysp      = 0;
						Grounded = true;
					}
				}
			}
		}
		break;
	}
	
	// If landed, update custom collision mode
	if Game.BetterPlayerTileGrip and Grounded
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
		
		// This will disable mode check for one frame, allowing us to land on ceilings safely
		CollisionMode[1] = true;
	}
}