function PlayerKnuxClimb()
{
	// Exit if not climbing
	if !ClimbState
	{
		exit;
	}  
	
	switch ClimbState
	{
		// Climb on walls
		case 1:
		{
			// Move up and down and all around
			if Input.Up
			{
				Ysp = -ClimbSpeed;
			}
			else if Input.Down
			{
				Ysp = ClimbSpeed;
			}
			else
			{
				Ysp = 0;
			}
		
			// Drop if no wall found in front of us
			var WallDistance  = tile_check_collision_h(PosX + RadiusX * Facing, PosY + 10, Facing, true, Layer)[0];
			if  WallDistance != 0
			{
				ClimbState = false;
				GlideState = GlideFall;
				Animation  = AnimClimbFall;
					
				// Reset collision radiuses
				RadiusX = DefaultRadiusX;
				RadiusY = DefaultRadiusY;
			
				// Reset gravity
				if !IsUnderwater
				{
					Grv	= 0.21875;
				}
				else
				{
					// Lower by 0x28 (0.15625) if underwater
					Grv = 0.0625
				}
			}
			else
			{
				// If near the edge, start climbering
				var EdgeDistance = tile_check_collision_h(PosX + RadiusX * Facing, PosY - 10, Facing, true, Layer)[0];
				if  EdgeDistance >= 4
				{
					Ysp		       = 0;
					ClimbState     = 2;
					AllowCollision = false;
				}
				
				// Check for jump
				else if Input.ABCPress
				{
					Facing	  *= -1;
					Jumping	   = true;
					ClimbState = false;
					Animation  = AnimSpin;
			
					// Set speeds
					Ysp	= -4;
					Xsp	= 3.5 * Facing;
			
					// Play sound
					audio_sfx_play(sfxJump, false);
				
					// Reset gravity
					if !IsUnderwater
					{
						Grv	= 0.21875;
					}
					else
					{
						// Lower by 0x28 (0.15625) if underwater
						Grv = 0.0625
					}
				}
				else
				{
					// Collide with ceiling
					var RoofDistance = tile_check_collision_v(PosX + RadiusX * Facing, PosY - DefaultRadiusY, false, true, Layer)[0];
					if  RoofDistance < 0
					{			
						PosY -= RoofDistance;
					}
	
					// Collide with floor
					var TileFloor = tile_check_collision_v(PosX + RadiusX * Facing, PosY + DefaultRadiusY, true, false, Layer);
					if  TileFloor[0] < 0
					{
						if TileFloor[1] <= 45 or TileFloor[1] >= 316.41
						{
							Grounded  = true;
							Animation = AnimIdle;
					
							// Adjust position
							PosY += DefaultRadiusY - RadiusY;
						}
					}
				}
			}
		}
		break;
		case 2:
		{	
			// Set vertical speed and animation
			if ClimbValue < 25
			{
				Animation = AnimClimbLedge;
			}
			Ysp = 0;
			
			// Adjust positon
			switch (++ClimbValue)
			{
				case 7:
				{
					PosX += 3 * Facing;
					PosY -= 2;
				}
				break;
				case 13:
				{
					PosX += 8 * Facing;
					PosY -= 10;
				}
				break;
				case 19:
				{
					PosX -= 8 * Facing;
					PosY -= 12;
				}
				break;
				case 25:
				{
					PosX += 8 * Facing;
					PosY += 4;
				
					// Land
					AllowCollision = true;
					Grounded       = true;
					Animation	   = AnimIdle;
				}
				break;
			}
		}
		break;
	}
}