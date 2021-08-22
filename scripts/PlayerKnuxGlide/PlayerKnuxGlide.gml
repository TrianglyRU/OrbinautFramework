function PlayerKnuxGlide()
{
	// Exit if not in glide state
	if !GlideState
	{
		exit;
	}
	
	// Air glide
	if GlideState == GlideActive and !GlideGrounded
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
			if GlideDirection = FlipLeft
			{	
				if GlideValue > 0
				{
					GlideValue -= 2.8125;		
					Xsp			= GlideSpeed * dcos(GlideValue) * -sign(GlideSpeed);
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
					Xsp			= GlideSpeed * dcos(GlideValue) * -sign(GlideSpeed);
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
			Animation = AnimGlide;
		}
		else
		{
			// Reset collision radiuses
			RadiusX	= DefaultRadiusX;
			RadiusY	= DefaultRadiusY;
			
			// Enter drop state
			GlideState = GlideDrop;
			Animation  = AnimGlideDrop;
		
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
	
	// Collide with left wall
	if Xsp < 0
	{
		var LeftWall = tile_check_collision_h(PosX - 10, PosY, false, true, Layer);
		if  LeftWall[0] < 0 
		{
			// Attach if wall is flat
			if GlideState == GlideActive and !GlideGrounded
			{
				if LeftWall[1] == 270
				{
					GlideState = false;
					ClimbState = true;
					ClimbValue = 0;
					RadiusY    = DefaultRadiusY;
			
					// Play sound
					audio_sfx_play(sfxGrab, false);
				}
			}
		
			// Clip out
			Xsp   = 0;
			PosX -= LeftWall[0];
		}
	}
	
	// Collide with right wall
	else if Xsp > 0
	{
		var RightWall = tile_check_collision_h(PosX + 10, PosY, true, true, Layer);
		if  RightWall[0] < 0
		{
			// Attach if wall is flat
			if GlideState == GlideActive and !GlideGrounded
			{
				if RightWall[1] == 90
				{
					GlideState = false;
					ClimbState = true;
					ClimbValue = 0;
					RadiusY    = DefaultRadiusY;
			
					// Play sound
					audio_sfx_play(sfxGrab, false);
				}
			}
			
			// Clip out
			Xsp   = 0;
			PosX += RightWall[0];
		}
	}
	
	// Check for ceiling
	var TileLeft    = tile_check_collision_v(PosX - RadiusX, PosY - RadiusY, false, true, Layer);
	var TileRight   = tile_check_collision_v(PosX + RadiusX, PosY - RadiusY, false, true, Layer);
	var NearestTile = tile_check_nearest(TileLeft, TileRight, noone);
				
	// Get data
	var RoofDistance = NearestTile[0];
	var RoofAngle    = NearestTile[1];
			
	// Collide with ceiling
	if RoofDistance < 0 and GlideState != GlideStop
	{	
		if Ysp < 0
		{
			Ysp = 0;
		}
		PosY -= RoofDistance;
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
		var FloorAngle    = NearestTile[1];
			
		// Check if we're airborne
		if !GlideGrounded
		{	
			if GlideState != GlideStop
			{
				// Collide with floor
				if FloorDistance < 0
				{
					if FloorAngle <= 45 or FloorAngle >= 315
					{
						// Start sliding if floor is shallow enough
						if GlideState == GlideActive
						{
							GlideValue    = 4;
							GlideGrounded = true;
								
							// Create dust effect
							instance_create(floor(PosX), floor(PosY + RadiusY + FloorDistance), DustPuff);
						}
						
						// If falling in drop state, land crouching
						else if GlideState == GlideDrop
						{	
							GlideState = GlideStop;
							GlideValue = 16;
							Xsp	       = 0;
								
							// Play sound
							audio_sfx_play(sfxLand, false);
						}
					}
				
					// Land normally if floor is too steep
					else
					{
						Angle    = FloorAngle;
						Grounded = true;
						Inertia  = Xsp;
						Xsp		 = 0;
					}
					
					// Reset vertical speed
					Ysp = 0;
					Grv = 0;
				}
			}
			
			// Restore control after 16 frames if landed crouching
			if GlideState == GlideStop
			{
				if !(--GlideValue)
				{
					Grounded = true;
				}
				PosY += FloorDistance;
			
				// Set animation
				Animation = AnimDropStand;
			}
		}
	
		// Slide on the ground
		if GlideGrounded
		{
			// Set animation
			Animation = AnimGlideGrounded;
		
			// Decelerate
			if Xsp > 0
			{
				Xsp = max(0, Xsp - AirAcc);
			}
			else
			{
				Xsp = min(0, Xsp + AirAcc);
			}
		
			// If no floor found below us, drop
			if FloorDistance > 14
			{
				GlideGrounded = false;
				GlideState    = GlideDrop;
				Animation     = AnimGlideDrop;
			
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
			
			// Collide with floor
			else
			{		
				// Adhere to the surface
				PosY += FloorDistance;
				
				// Crouch for 16 frames if not moving anymore, then restore contols
				if Xsp == 0 or !Input.ABC
				{
					if GlideState != GlideStop
					{
						GlideValue = 16;
						GlideState = GlideStop;
					}
					if !(--GlideValue)
					{
						Angle    = FloorAngle;
						Grounded = true;
					}
					Xsp	= 0;
			
					// Set animation
					Animation = AnimGlideStand;
			
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
		}
			
		// If crouching, check for jump
		if GlideState == GlideStop and Input.ABCPress
		{
			// Exit if found low ceiling
			if tile_check_collision_v(PosX - RadiusX, PosY - RadiusY, false, true, Layer)[0] < 6
			or tile_check_collision_v(PosX + RadiusX, PosY - RadiusY, false, true, Layer)[0] < 6
			{
				exit;
			}
				
			// Set speeds
			Xsp += Jump * dsin(Angle);
			Ysp	+= Jump * dcos(Angle);	
			
			// Play sound
			audio_sfx_play(sfxJump, false);
		
			// Update flags
			Jumping    = true;
			Spinning   = true;
			Grounded   = false;
			GlideState = false;
			Animation  = AnimSpin;
			
			// Update collision radiuses
			RadiusX = SmallRadiusX;
			RadiusY = SmallRadiusY;
			PosY   += DefaultRadiusY - SmallRadiusY;
					
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
	}
}