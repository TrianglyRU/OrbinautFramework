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
			Grv = Ysp < 0.5 ? 0.125 : -0.125;
		
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
				
				/// Turn
				if Input.RightPress
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
				if Input.LeftPress
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
					GlideFrame = 3;
				}
				else if GlideValue > 30
				{
					GlideFrame = 2;
				}
				else
				{
					GlideFrame = 1;
				}
			}
			else if GlideValue < 150
			{
				GlideFrame = 2;
			}		
			else
			{
				GlideFrame = 1;
			}
			
			// Set animation
			Animation = AnimGlide;
		}
		else
		{
			// Enter drop state
			Xsp       *= 0.25;
			GlideState = GlideDrop;
			Animation  = AnimGlideDrop;
			
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
	}
	
	// Check for walls
	var LeftDistance  = Xsp <= 0 ? tile_check_collision_h(floor(PosX - 10), floor(PosY), false, true, Layer)[0] : 16;
	var RightDistance = Xsp >= 0 ? tile_check_collision_h(floor(PosX + 10), floor(PosY), true,  true, Layer)[0] : 16;
			
	// Collide with left or right wall
	if LeftDistance < 0 or RightDistance < 0
	{
		// Clip out and reset speed
		if LeftDistance < 0
		{
			PosX -= LeftDistance;
		}
		else if RightDistance < 0
		{
			PosX += RightDistance;
		}
		Xsp = 0;
		
		// If gliding in the air, attach to the wall
		if GlideState == GlideActive and !GlideGrounded
		{
			// Reset speed
			Ysp = 0;
			
			// Set flags
			GlideState = false;
			ClimbState = true;
			ClimbValue = 0;
			RadiusY    = DefaultRadiusY;
			
			// Play sound
			audio_sfx_play(sfxGrab, false);
		}	
	}
			
	// Try ceiling collision
	else
	{
		// Check for ceiling
		var TileLeft    = tile_check_collision_v(floor(PosX - RadiusX), floor(PosY - RadiusY), false, true, Layer);
		var TileRight   = tile_check_collision_v(floor(PosX + RadiusX), floor(PosY - RadiusY), false, true, Layer);
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
			var TileLeft    = tile_check_collision_v(floor(PosX - RadiusX), floor(PosY + RadiusY), true, false, Layer);
			var TileRight   = tile_check_collision_v(floor(PosX + RadiusX), floor(PosY + RadiusY), true, false, Layer);
			var NearestTile = tile_check_nearest(TileLeft, TileRight, noone);
					
			// Get data
			var FloorDistance = NearestTile[0];
			var FloorAngle    = NearestTile[1];
			
			// Check if we're airborne
			if !GlideGrounded
			{	
				if GlideState != GlideStop
				{
					if FloorDistance < 0
					{
						// Reset vertical speed
						Ysp = 0;
						Grv = 0;
				
						// Slide if floor is shallow enough
						if FloorAngle <= 45 or FloorAngle >= 315
						{
							if GlideState == GlideActive
							{
								GlideValue    = 0;
								GlideGrounded = true;
								
								// Create dust effect
								instance_create(floor(PosX), floor(PosY + RadiusY), DustPuff);
							}
							else if GlideState == GlideDrop
							{
								PosY += FloorDistance;
								
								GlideState = GlideStop;
								GlideValue = 16;
								Xsp	       = 0;
								
								// Play sound
								audio_sfx_play(sfxLand, false);
							}
						}
				
						// Land if floor is too steep
						else
						{
							Angle    = FloorAngle;
							Inertia  = FloorAngle < 180 ? -Ysp : Ysp;
							Grounded = true;
							Xsp		 = 0;
						}
					}
				}
				if GlideState == GlideStop
				{
					// Land
					if !(--GlideValue)
					{
						Angle    = FloorAngle;
						Grounded = true;
					}
			
					// Set animation
					Animation = AnimDropStand;
				}
			}
	
			// Check if we're sliding
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
		
				// If no surface found below us, drop
				if FloorDistance > 14
				{
					// Set flags
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
				else
				{		
					// Adhere to the surface
					PosY += FloorDistance;
					
					// Exit slide state if stopped
					if Xsp == 0 or !Input.ABC
					{
						// Land
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
					
					// Play slide sound each 8th frame
					else if (++GlideValue) mod 8 == 0
					{
						audio_sfx_play(sfxSlide, false);
					}
				}
			}
			
			// If in stop state, check for jumping
			if GlideState == GlideStop and Input.ABCPress
			{
				// Exit if found low ceiling
				if tile_check_collision_v(floor(PosX - RadiusX), floor(PosY - RadiusY), false, true, Layer)[0] < 6
				or tile_check_collision_v(floor(PosX + RadiusX), floor(PosY - RadiusY), false, true, Layer)[0] < 6
				{
					exit;
				}
				
				// Set speeds
				Xsp += Jump * dsin(Angle);
				Ysp	+= Jump * dcos(Angle);	
		
				// Update flags
				Jumping    = true;
				Grounded   = false;
				GlideState = false;
				Animation  = AnimRoll;
	
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
		}
	}
}