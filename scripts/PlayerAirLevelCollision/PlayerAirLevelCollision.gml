function PlayerAirLevelCollision()
{
	// Exit if died
	if Player.Death or Player.Drown
	{
		exit;
	}
	
	// Get movement angle quadrant
	if abs(Xsp) >= abs(Ysp)
	{
		var MoveDir = Xsp > 0 ? "MoveRight" : "MoveLeft";
	}
	else
	{
		var MoveDir = Ysp > 0 ? "MoveDown" : "MoveUp";
	}
	
	// Run the code based on quadrant
	switch MoveDir
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
			var FloorLeft  = tile_check_collision_v(floor(PosX - xRadius), floor(PosY + yRadius), true, false, Layer);
			var FloorRight = tile_check_collision_v(floor(PosX + xRadius), floor(PosY + yRadius), true, false, Layer);
			
			/* [0] is distance, [1] is angle */
			
			// Find nearest tile
			if FloorLeft[0] <= FloorRight[0]
			{
				var FloorDistance = FloorLeft[0];
				var FloorAngle    = FloorLeft[1];
			}
			else
			{	
				var FloorDistance = FloorRight[0];
				var FloorAngle    = FloorRight[1];
			}
			
			// Are we touching the floor within the clip distance?
			var ClipDistance = -(Ysp + 8)
			if  FloorDistance < 0 and (FloorLeft[0] >= ClipDistance or FloorRight[0] >= ClipDistance)
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
				PosY	+= FloorDistance;
				Angle    = FloorAngle;
				
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
			var RoofLeft  = tile_check_collision_v(floor(PosX - xRadius), floor(PosY - yRadius), false, true, Layer);
			var RoofRight = tile_check_collision_v(floor(PosX + xRadius), floor(PosY - yRadius), false, true, Layer);
			
			/* [0] is distance, [1] is angle */
		
			// Find nearest tile
			if RoofLeft[0] <= RoofRight[0]
			{
				var RoofDistance = RoofLeft[0];
				var RoofAngle    = RoofLeft[1];
			}
			else
			{
				var RoofDistance = RoofRight[0];
				var RoofAngle    = RoofRight[1];
			}
			
			// Are we touching the ceiling?
			if RoofDistance < 0
			{	
				// Clip out
				PosY -= RoofDistance;
			
				// Land on ceiling
				if !FlyingState and (RoofAngle <= 135 or RoofAngle >= 225)
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
					if FlyingState
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
				
				// Set inertia to... ysp??
				Inertia = Ysp;
			}
			
			// If we're not touching the wall, try floor or ceiling collision
			else
			{
				// Check for ceiling
				var RoofLeft  = tile_check_collision_v(floor(PosX - xRadius), floor(PosY - yRadius), false, true, Layer);
				var RoofRight = tile_check_collision_v(floor(PosX + xRadius), floor(PosY - yRadius), false, true, Layer);
			
				/* [0] is distance, [1] is angle */
		
				// Find nearest tile
				if RoofLeft[0] <= RoofRight[0]
				{
					var RoofDistance = RoofLeft[0];
					var RoofAngle    = RoofLeft[1];
				}
				else
				{
					var RoofDistance = RoofRight[0];
					var RoofAngle    = RoofRight[1];
				}
			
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
					if FlyingState
					{
						Grv	= 0.03125;
					}
				}
				
				// If we're not touching the ceiling, do floor collision if we're moving downwards
				else if Ysp > 0
				{
					// Check for floor
					var FloorLeft  = tile_check_collision_v(floor(PosX - xRadius), floor(PosY + yRadius), true, false, Layer);
					var FloorRight = tile_check_collision_v(floor(PosX + xRadius), floor(PosY + yRadius), true, false, Layer);
			
					/* [0] is distance, [1] is angle */
			
					// Find nearest tile
					if FloorLeft[0] <= FloorRight[0]
					{
						var FloorDistance = FloorLeft[0];
						var FloorAngle    = FloorLeft[1];
					}
					else
					{	
						var FloorDistance = FloorRight[0];
						var FloorAngle    = FloorRight[1];
					}
			
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
				
				// Set inertia to... ysp??
				Inertia = Ysp;
			}
			
			// If we're not touching the wall, try floor or ceiling collision
			else
			{
				// Check for ceiling
				var RoofLeft  = tile_check_collision_v(floor(PosX - xRadius), floor(PosY - yRadius), false, true, Layer);
				var RoofRight = tile_check_collision_v(floor(PosX + xRadius), floor(PosY - yRadius), false, true, Layer);
			
				/* [0] is distance, [1] is angle */
		
				// Find nearest tile
				if RoofLeft[0] <= RoofRight[0]
				{
					var RoofDistance = RoofLeft[0];
					var RoofAngle    = RoofLeft[1];
				}
				else
				{
					var RoofDistance = RoofRight[0];
					var RoofAngle    = RoofRight[1];
				}
			
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
					if FlyingState
					{
						Grv	= 0.03125;
					}
				}
				
				// If we're not touching the ceiling, do floor collision if we're moving downwards
				else if Ysp > 0
				{
					// Check for floor
					var FloorLeft  = tile_check_collision_v(floor(PosX - xRadius), floor(PosY + yRadius), true, false, Layer);
					var FloorRight = tile_check_collision_v(floor(PosX + xRadius), floor(PosY + yRadius), true, false, Layer);
			
					/* [0] is distance, [1] is angle */
			
					// Find nearest tile
					if FloorLeft[0] <= FloorRight[0]
					{
						var FloorDistance = FloorLeft[0];
						var FloorAngle    = FloorLeft[1];
					}
					else
					{	
						var FloorDistance = FloorRight[0];
						var FloorAngle    = FloorRight[1];
					}
			
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