function PlayerKnuxClimb()
{
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
			
			// Check for jump
			if Input.ABCPress
			{
				Facing	  *= -1;
				Jumping	   = true;
				Spinning   = true;
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
				var FindRoof = tile_find_v(PosX + RadiusX * Facing, PosY - DefaultRadiusY, false, true, Layer)[0];
				if  FindRoof < 0
				{
					PosY -= FindRoof;
				}
				else
				{
					// Collide with floor
					var FindFloor = tile_find_v(PosX + RadiusX * Facing, PosY + DefaultRadiusY, true, false, Layer);
					if  FindFloor[0] < 0
					{
						if FindFloor[1] <= 45 or FindFloor[1] >= 316.41
						{
							Grounded  = true;
							Animation = AnimIdle;
					
							// Adjust position
							PosY += FindFloor[0] + DefaultRadiusY - RadiusY; break;
						}
					}
				}
				
				// Drop if no tile found in front of us or we're actually inside of it (like there is slope below us, for example)
				var FindWall = tile_find_h(PosX + RadiusX * Facing, PosY + 10, Facing, false, Layer);
				if  FindWall[0] < 0 or FindWall[1] == noone
				{
					ClimbState = false;
					GlideState = GlideFall;
					Animation  = AnimDrop;
					
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
					break;
				}
				
				// If no tile found above us, start clambering
				var FindWall = tile_find_h(PosX + RadiusX * Facing, PosY - 10, Facing, false, Layer);
				if  FindWall[1] == noone
				{
					Ysp		   = 0;
					ClimbState = 2;
					
					// Align to the edge
					var Align = tile_find_v(PosX + (RadiusX + 1) * Facing, PosY - 11, true, false, Layer)[0];
					if  Align
					{
						PosY += Align; 
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
				Animation = AnimClamber;
			}
			Ysp = 0;
			
			// Adjust positon
			switch (++ClimbValue)
			{
				case 7:
				{
					PosX += 3 * Facing;
					PosY -= 3;
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
					Grounded  = true;
					Animation = AnimIdle;
				}
				break;
			}
		}
		break;
	}
}