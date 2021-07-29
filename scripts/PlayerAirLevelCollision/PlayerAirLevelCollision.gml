function PlayerAirLevelCollision()
{
	// Exit if we've died
	if Death or Drown
	{
		exit;
	}
	
	// Exit if climbing or gliding
	if ClimbState or GlideState
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
	
	// Run the code based on quadrant
	switch MoveDirection
	{
		case "MoveDown":
		{
			// Check for left wall
			var LeftDistance = tile_check_collision_h(floor(PosX - 10), floor(PosY), false, true, Layer)[0];
			if  LeftDistance < 0
			{
				// Collide if distance is less than 0
				PosX -= LeftDistance;
				Xsp   = 0;
			}
			
			// Check for right wall
			var RightDistance = tile_check_collision_h(floor(PosX + 10), floor(PosY), true, true, Layer)[0];
			if  RightDistance < 0
			{
				// Collide if distance is less than 0
				PosX += RightDistance;
				Xsp   = 0;
			}
			
			// Check for floor
			var TileLeft  = tile_check_collision_v(floor(PosX - RadiusX), floor(PosY + RadiusY), true, false, Layer);
			var TileRight = tile_check_collision_v(floor(PosX + RadiusX), floor(PosY + RadiusY), true, false, Layer);
			
			// Get nearest tile
			var NearestTile = tile_check_nearest(TileLeft, TileRight, noone);
			
			// Get data
			var FloorDistance = NearestTile[0];
			var FloorAngle    = NearestTile[1];
			
			// Are we touching the floor within the clip distance?
			var ClipDistance = -(Ysp + 8)
			if  FloorDistance < 0 and (TileLeft[0] >= ClipDistance or TileRight[0] >= ClipDistance)
			{
				// Use full vertical speed on full steep floor
				if FloorAngle >= 46.41 and FloorAngle <= 315
				{
					Xsp		= 0;
					Inertia = FloorAngle < 180 ? -Ysp : Ysp;
				}
		
				// Use halved vertical speed on half steep floor
				else if FloorAngle >= 23.91 and FloorAngle <= 337.5
				{
					Inertia = FloorAngle < 180 ? -Ysp / 2 : Ysp / 2;
				}
		
				// Use horizontal speed on shallow floor
				else 
				{	
					Ysp     = 0;
					Inertia = Xsp;	
				}

				// Adhere to the surface and inherit floor angle
				PosY += FloorDistance;
				Angle = FloorAngle;
				
				// Set flag
				Grounded = true;
			}	
		}
		break;	
		case "MoveUp":
		{
			// Check for left wall
			var LeftDistance = tile_check_collision_h(floor(PosX - 10), floor(PosY), false, true, Layer)[0];
			if  LeftDistance < 0
			{
				// Collide if distance is less than 0
				PosX -= LeftDistance;
				Xsp   = 0;
			}
			
			// Check for right wall
			var RightDistance = tile_check_collision_h(floor(PosX + 10), floor(PosY), true, true, Layer)[0];
			if  RightDistance < 0
			{
				// Collide if distance is less than 0
				PosX += RightDistance;
				Xsp   = 0;
			}
			
			// Check for ceiling
			var TileLeft  = tile_check_collision_v(floor(PosX - RadiusX), floor(PosY - RadiusY), false, true, Layer);
			var TileRight = tile_check_collision_v(floor(PosX + RadiusX), floor(PosY - RadiusY), false, true, Layer);
				
			// Get nearest tile
			var NearestTile = tile_check_nearest(TileLeft, TileRight, noone);
			
			// Get data
			var RoofDistance = NearestTile[0];
			var RoofAngle    = NearestTile[1];
			
			// Are we touching the ceiling?
			if RoofDistance < 0
			{	
				// Clip out
				PosY -= RoofDistance;
			
				// Land on ceiling
				if (RoofAngle >= 91.41 and RoofAngle <= 136.41 or RoofAngle >= 226.41 and RoofAngle <= 268.59) and !FlightState
				{
					// Set inertia and inherit ceiling angle
					Angle    = RoofAngle;
					Inertia  = RoofAngle < 180 ? -Ysp : Ysp;
				
					// Set flag
					Grounded = true;
				}
				
				// ...or stop
				else 
				{
					// Reset ysp
					Ysp = 0;
					
					// Reset gravity if flying
					if FlightState
					{
						Grv	= 0.03125;
					}				
				}
			}
		}
		break;		
		case "MoveLeft":
		{
			// Check for left wall
			var LeftDistance = tile_check_collision_h(floor(PosX - 10), floor(PosY), false, true, Layer)[0];
			if  LeftDistance < 0
			{
				// Collide if distance is less than 0
				PosX -= LeftDistance;
				Xsp   = 0;
				
				// Set inertia to... ysp?
				Inertia = Ysp;
			}
			
			// If we're not touching the wall, try floor or ceiling collision
			else
			{
				// Check for ceiling
				var TileLeft  = tile_check_collision_v(floor(PosX - RadiusX), floor(PosY - RadiusY), false, true, Layer);
				var TileRight = tile_check_collision_v(floor(PosX + RadiusX), floor(PosY - RadiusY), false, true, Layer);
				
				// Get nearest tile
				var NearestTile = tile_check_nearest(TileLeft, TileRight, noone);
				
				// Get data
				var RoofDistance = NearestTile[0];
				var RoofAngle    = NearestTile[1];
			
				// Are we touching the ceiling?
				if RoofDistance < 0
				{	
					// Clip out
					PosY -= RoofDistance;
			
					// Reset Ysp
					if Ysp < 0
					{
						Ysp = 0;
					}
					
					// Reset gravity if flying
					if FlightState
					{
						Grv	= 0.03125;
					}
				}
				
				// If we're not touching the ceiling, do floor collision if we're moving downwards
				else if Ysp > 0
				{
					// Check for floor
					var TileLeft  = tile_check_collision_v(floor(PosX - RadiusX), floor(PosY + RadiusY), true, false, Layer);
					var TileRight = tile_check_collision_v(floor(PosX + RadiusX), floor(PosY + RadiusY), true, false, Layer);
				
					// Get nearest tile
					var NearestTile = tile_check_nearest(TileLeft, TileRight, noone);
					
					// Get data
					var FloorDistance = NearestTile[0];
					var FloorAngle    = NearestTile[1];
			
					// Are we touching the floor?
					if FloorDistance < 0
					{
						// Set speeds	
						Ysp     = 0;
						Inertia = Xsp;	
						
						// Adhere to the surface and inherit floor angle
						PosY	+= FloorDistance;
						Angle    = FloorAngle;
				
						// Set flag
						Grounded = true;
					}
				}
			}
		}
		break;
		case "MoveRight":
		{
			// Check for right wall
			var RightDistance = tile_check_collision_h(floor(PosX + 10), floor(PosY), true, true, Layer)[0];
			if  RightDistance < 0
			{
				// Collide if distance is less than 0
				PosX += RightDistance;
				Xsp   = 0;
				
				// Set inertia to... ysp?
				Inertia = Ysp;
			}
			
			// If we're not touching the wall, try floor or ceiling collision
			else
			{
				// Check for ceiling
				var TileLeft  = tile_check_collision_v(floor(PosX - RadiusX), floor(PosY - RadiusY), false, true, Layer);
				var TileRight = tile_check_collision_v(floor(PosX + RadiusX), floor(PosY - RadiusY), false, true, Layer);
				
				// Get nearest tile
				var NearestTile = tile_check_nearest(TileLeft, TileRight, noone);
				
				// Get data
				var RoofDistance = NearestTile[0];
				var RoofAngle    = NearestTile[1];
			
				// Are we touching the ceiling?
				if RoofDistance < 0
				{	
					// Clip out
					PosY -= RoofDistance;
			
					// Reset Ysp
					if Ysp < 0
					{
						Ysp = 0;
					}
					
					// Reset gravity if flying
					if FlightState
					{
						Grv	= 0.03125;
					}
				}
				
				// If we're not touching the ceiling, do floor collision if we're moving downwards
				else if Ysp > 0
				{
					// Check for floor
					var TileLeft  = tile_check_collision_v(floor(PosX - RadiusX), floor(PosY + RadiusY), true, false, Layer);
					var TileRight = tile_check_collision_v(floor(PosX + RadiusX), floor(PosY + RadiusY), true, false, Layer);
				
					// Get nearest tile
					var NearestTile = tile_check_nearest(TileLeft, TileRight, noone);
					
					// Get data
					var FloorDistance = NearestTile[0];
					var FloorAngle    = NearestTile[1];
			
					// Are we touching the floor?
					if FloorDistance < 0
					{
						// Set speeds	
						Ysp     = 0;
						Inertia = Xsp;	
						
						// Adhere to the surface and inherit floor angle
						PosY	+= FloorDistance;
						Angle    = FloorAngle;
				
						// Set flag
						Grounded = true;
					}
				}
			}
		}
		break;
	}
}