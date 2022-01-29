function PlayerKnuxGlide()
{
	// Exit if not in glide state
	if !GlideState
	{
		exit;
	}
	
	switch GlideState
	{
		case GlideAir:
		{
			if Input.ABC
			{
				// Apply gravity
				if Ysp < 0.5
				{
					Grv = 0.125;
				}
				else if Ysp > 0.5
				{
					Grv = -0.125;
				}
			
				// Glide to the left
				if GlideDirection == FlipLeft
				{	
					if GlideValue > 0
					{
						GlideValue -= 2.8125;		
						Xsp	= GlideSpeed * dcos(GlideValue) * -sign(GlideSpeed);
					}
					else
					{
						Xsp = max(Xsp - GlideAcc, -24);
					}
				
					// Turn
					if Input.Right
					{
						if GlideValue == 0
						{
							GlideSpeed = Xsp;
						}
						GlideDirection = FlipRight;
					}
				}
		
				// Glide to the right
				else if GlideDirection == FlipRight
				{	
					if GlideValue < 180
					{
						GlideValue += 2.8125;
						Xsp	= GlideSpeed * dcos(GlideValue) * -sign(GlideSpeed);
					}
					else
					{
						Xsp = min(Xsp + GlideAcc, 24);
					}
				
					// Turn
					if Input.Left
					{
						if GlideValue == 180
						{
							GlideSpeed = Xsp;
						}
						GlideDirection = FlipLeft;
					}
				}
		
				// Set facing direction
				Facing = GlideValue > 90 ? FlipRight : FlipLeft;
		
				// Define animation frame
				if GlideValue < 120
				{
					if GlideValue > 60
					{
						GlideFrame = 2;
					}
					else if GlideValue > 30
					{
						GlideFrame = 1;
					}
					else
					{
						GlideFrame = 0;
					}
				}
				else if GlideValue < 150
				{
					GlideFrame = 1;
				}		
				else
				{
					GlideFrame = 0;
				}
			}
			else
			{
				// Reset collision radiuses
				RadiusX	= DefaultRadiusX;
				RadiusY	= DefaultRadiusY;
			
				// Enter fall state
				GlideState = GlideFall;
				Animation  = AnimGlideFall;
		
				// Reset gravity
				if !IsUnderwater
				{
					Grv	= 0.21875;
				}
				else
				{
					// Reduce by 0x28 (0.15625) if underwater
					Grv = 0.0625
				}
				Xsp *= 0.25;
			}
		}
		break;
		case GlideGround:
		{	
			// Decelerate
			if Xsp > 0
			{
				Xsp = max(0, Xsp - AirAcc);
			}
			else
			{
				Xsp = min(0, Xsp + AirAcc);
			}	
			
			// Stop sliding if not moving anymore or forced to roll
			if Xsp == 0 or !Input.ABC or ForcedRoll
			{
				if !Input.ABC
				{
					Xsp	= 0;
				}
				Animation  = AnimGlideStand;
				Grounded   = true;
				GroundLock = 16;
			
				// Reset collision radiuses
				PosY   -= DefaultRadiusY - RadiusY;
				RadiusX = DefaultRadiusX;
				RadiusY = DefaultRadiusY;
			}
					
			// Play sound each 8th frame while sliding
			else if (GlideValue++) mod 8 == 0
			{
				audio_sfx_play(sfxSlide, false);
			}
		}
		break;
	}
	
	/* From here everything below is level collision 
	and is not recommended to edit unless you know what are you doing */
	
	// Collide with left wall
	var FindWall = tile_find_h(PosX - RadiusX, PosY, false, true, Layer);
	if  FindWall[0] < 0
	{
		if !(Xsp > 0)
		{
			// Clip out
			PosX -= FindWall[0];
			Xsp   = 0;
		
			// Attach to it
			if GlideState == GlideAir and FindWall[1] mod 90 == 0
			{
				GlideState = false;
				ClimbState = ClimbWall;
				ClimbValue = 0;
				Ysp		   = 0;
				Animation  = AnimClimb;

				// Play sound
				audio_sfx_play(sfxGrab, false); exit;
			}
		}	
	}
			
	// Collide with right wall
	var FindWall = tile_find_h(PosX + RadiusX, PosY, true, true, Layer);
	if  FindWall[0] < 0
	{
		if !(Xsp < 0)
		{
			// Clip out
			PosX += FindWall[0];
			Xsp   = 0;
		
			// Attach to it
			if GlideState == GlideAir and FindWall[1] mod 90 == 0
			{
				GlideState = false;
				ClimbState = ClimbWall;
				ClimbValue = 0;
				Ysp		   = 0;
				Animation  = AnimClimb;
			
				// Play sound
				audio_sfx_play(sfxGrab, false); exit;
			}	
		}
	}
	
	// Collide with ceiling if not falling down
	var FindRoof = tile_find_2v(PosX - RadiusX, PosY - RadiusY, PosX + RadiusX, PosY - RadiusY, false, true, noone, Layer);
	if  FindRoof[0] < 0
	{	
		if GlideState != GlideFall
		{
			Ysp   = 0;			
			PosY -= FindRoof[0];
		}
	}
	
	// Collid with floor if moving down
	else if Ysp >= 0
	{
		// Get tile below us
		var FindFloor = tile_find_2v(PosX - RadiusX, PosY + RadiusY, PosX + RadiusX, PosY + RadiusY, true, false, noone, Layer);
		
		// Update angle
		Angle = FindFloor[1];
		
		// Are we airborne?
		if GlideState != GlideGround 
		{
			if ForcedRoll
			{
				PosY    += FindFloor[0];
				Grounded = true;
			}
			else if FindFloor[0] < 0
			{
				// If floor is shallow enough, change state
				if Angle <= 45 or Angle >= 316.41
				{
					if GlideState == GlideAir
					{
						GlideState = GlideGround;
						Animation  = AnimSlide;
						GlideValue = 8;
						Grv		   = 0;
						Ysp		   = 0;
					
						// Create dust object
						instance_create(PosX, PosY + RadiusY + FindFloor[0], DustPuff);
					}
					else if GlideState == GlideFall
					{
						Grounded   = true;
						Xsp		   = 0;
						GroundLock = 16;
						Animation  = AnimDropStand;
						
						// Play sound
						audio_sfx_play(sfxLand, false);
					}
				}
			
				// Else just land
				else
				{
					Grounded = true;
					Inertia  = -Xsp;
				}
			
				// Clip to the surface
				PosY += FindFloor[0];
			}
		}
		
		// Are we sliding?
		else 
		{
			// If no ground found, fall
			if FindFloor[0] > 14
			{
				GlideState = GlideFall;
				Animation  = AnimGlideFall;
			
				// Reset collision radiuses
				RadiusX	= DefaultRadiusX;
				RadiusY	= DefaultRadiusY;
					
				// Reset gravity
				if !IsUnderwater
				{
					Grv	= 0.21875;
				}
				else
				{
					// Reduce by 0x28 (0.15625) if underwater
					Grv = 0.0625
				}
			}
			
			// Else clip to the surface
			else
			{
				PosY += FindFloor[0];
			}
		}
	}
}