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
					// Lower by 0x28 (0.15625) if underwater
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
			
			// Leave state if not moving anymore
			if Xsp == 0 or !Input.ABC
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
	var LeftWall = tile_check_collision_h(PosX - RadiusX, PosY, false, true, Layer);
	if  LeftWall[0] < 0
	{
		// Attach if wall is flat
		if GlideState == GlideAir and Xsp <= 0
		{
			if LeftWall[1] == 270
			{
				GlideState = false;
				ClimbState = true;
				ClimbValue = 0;
				Ysp		   = 0;
				
				// Play sound
				audio_sfx_play(sfxGrab, false);
				
				// Set animation
				Animation = AnimClimb;
			}	
		}
		
		// Clip out
		PosX -= LeftWall[0];
		Xsp   = 0;
	}
			
	// Collide with right wall
	var RightWall = tile_check_collision_h(PosX + RadiusX, PosY, true, true, Layer);
	if  RightWall[0] < 0
	{
		// Attach if wall is flat
		if GlideState == GlideAir and Xsp >= 0
		{
			if RightWall[1] == 90
			{
				GlideState = false;
				ClimbState = true;
				ClimbValue = 0;
				Ysp		   = 0;
			
				// Play sound
				audio_sfx_play(sfxGrab, false);
				
				// Set animation
				Animation = AnimClimb;
			}
		}
			
		// Clip out
		PosX += RightWall[0];
		Xsp   = 0;
	}
	
	// Exit the rest of the code if we've attached to the wall
	if ClimbState
	{
		exit;
	}
	
	// Get nearest tile above us
	var TileLeft    = tile_check_collision_v(PosX - RadiusX, PosY - RadiusY, false, true, Layer);
	var TileRight   = tile_check_collision_v(PosX + RadiusX, PosY - RadiusY, false, true, Layer);
	var NearestTile = tile_check_nearest(TileLeft, TileRight, noone);
			
	// Collide with ceiling
	if NearestTile[0] < 0
	{	
		Ysp   = 0;			
		PosY -= NearestTile[0];
	}
	
	// Try floor collision
	else if Ysp >= 0
	{
		// Get nearest tile below us
		var TileLeft    = tile_check_collision_v(PosX - RadiusX, PosY + RadiusY, true, false, Layer);
		var TileRight   = tile_check_collision_v(PosX + RadiusX, PosY + RadiusY, true, false, Layer);
		var NearestTile = tile_check_nearest(TileLeft, TileRight, noone);
		
		// Get data
		var FloorDistance = NearestTile[0];
		Angle			  = NearestTile[1];
	
		// Check if we're gliding and distance is negative
		if GlideState != GlideGround 
		{
			if FloorDistance < 0
			{
				// If floor is shallow enough, change state
				if Angle <= 45 or Angle >= 316.41
				{
					if GlideState == GlideAir
					{
						GlideState = GlideGround;
						Animation  = AnimSlide;
						GlideValue = 8;
							
						// Reset gravity
						Grv = 0;
						Ysp = 0;
					
						// Create dust object
						instance_create(PosX, PosY + RadiusY + FloorDistance, DustPuff);
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
			
				// Adhere to the surface
				PosY += FloorDistance;
			}
		}
		else 
		{
			// If sliding and no ground found, fall
			if FloorDistance > 14
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
					// Lower by 0x28 (0.15625) if underwater
					Grv = 0.0625
				}
			}
			
			// Clip to the surface
			else
			{
				PosY += FloorDistance;
			}
		}
	}
}