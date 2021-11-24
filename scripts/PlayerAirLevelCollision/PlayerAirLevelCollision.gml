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
			
			// Get nearest tile below us
			var FindFloor1 = tile_find_v(PosX - RadiusX, PosY + RadiusY, true, false, Layer);
			var FindFloor2 = tile_find_v(PosX + RadiusX, PosY + RadiusY, true, false, Layer);
			var FindFloor3 = tile_compare(FindFloor1, FindFloor2, noone);
			
			// Collide with floor
			if FindFloor3[0] < 0
			{
				// Make sure at least one distance is within the clip distance
				var ClipDistance   = -(Ysp + 8)
				if  FindFloor1[0] >= ClipDistance or FindFloor2[0] >= ClipDistance
				{
					// Convert speed to inertia
					if FindFloor3[1] >= 46.41 and FindFloor3[1] <= 315
					{
						// Limit ysp
						if Ysp > 15.75
						{
							Ysp = 15.75;
						}
						Xsp		= 0;
						Inertia = FindFloor3[1] < 180 ? -Ysp : Ysp;
					}
					else if FindFloor3[1] >= 23.91 and FindFloor3[1] <= 337.5
					{
						Inertia = FindFloor3[1] < 180 ? -Ysp / 2 : Ysp / 2;
					}
					else 
					{	
						Ysp     = 0;
						Inertia = Xsp;	
					}
					
					// Clip out and land
					PosY    += FindFloor3[0];
					Angle    = FindFloor3[1];
					Grounded = true;
				}
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
			
			// Get nearest tile above us
			var FindRoof1 = tile_find_v(PosX - RadiusX, PosY - RadiusY, false, true, Layer);
			var FindRoof2 = tile_find_v(PosX + RadiusX, PosY - RadiusY, false, true, Layer);
			var FindRoof3 = tile_compare(FindRoof1, FindRoof2, noone);
			
			// Collide with ceiling
			if FindRoof3[0] < 0
			{	
				if (FindRoof3[1] >= 91.41  and FindRoof3[1] <= 136.41 
				or  FindRoof3[1] >= 226.41 and FindRoof3[1] <= 268.59) and !FlightState
				{
					Angle    = FindRoof3[1];
					Inertia  = FindRoof3[1] < 180 ? -Ysp : Ysp;
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
				PosY -= FindRoof3[0];
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
				// Get nearest tile above us
				var FindRoof1 = tile_find_v(PosX - RadiusX, PosY - RadiusY, false, true, Layer);
				var FindRoof2 = tile_find_v(PosX + RadiusX, PosY - RadiusY, false, true, Layer);
				var FindRoof3 = tile_compare(FindRoof1, FindRoof2, noone);
				
				// Collide with ceiling
				if FindRoof3[0] < 0
				{	
					if Ysp < 0
					{
						Ysp = 0;
					}
					if FlightState
					{
						Grv	= 0.03125;
					}
					PosY -= FindRoof3[0];
				}
				
				// Try floor collision
				else if Ysp > 0
				{
					// Get nearest tile below us
					var FindFloor1 = tile_find_v(PosX - RadiusX, PosY + RadiusY, true, false, Layer);
					var FindFloor2 = tile_find_v(PosX + RadiusX, PosY + RadiusY, true, false, Layer);
					var FindFloor3 = tile_compare(FindFloor1, FindFloor2, noone);
					
					// Collide with floor
					if FindFloor3[0] < 0
					{
						PosY	+= FindFloor3[0];
						Angle    = FindFloor3[1];
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
				// Get nearest tile above us
				var FindRoof1 = tile_find_v(PosX - RadiusX, PosY - RadiusY, false, true, Layer);
				var FindRoof2 = tile_find_v(PosX + RadiusX, PosY - RadiusY, false, true, Layer);
				var FindRoof3 = tile_compare(FindRoof1, FindRoof2, noone);
				
				// Collide with ceiling
				if FindRoof3[0] < 0
				{	
					if Ysp < 0
					{
						Ysp = 0;
					}
					if FlightState
					{
						Grv	= 0.03125;
					}
					PosY -= FindRoof3[0];
				}
				
				// Try floor collision
				else if Ysp > 0
				{
					// Get nearest tile below us
					var FindFloor1 = tile_find_v(PosX - RadiusX, PosY + RadiusY, true, false, Layer);
					var FindFloor2 = tile_find_v(PosX + RadiusX, PosY + RadiusY, true, false, Layer);
					var FindFloor3 = tile_compare(FindFloor1, FindFloor2, noone);
					
					// Collide with floor
					if FindFloor3[0] < 0
					{
						PosY	+= FindFloor3[0];
						Angle    = FindFloor3[1];
						Inertia  = Xsp
						Ysp      = 0;
						Grounded = true;
					}
				}
			}
		}
		break;
	}
}