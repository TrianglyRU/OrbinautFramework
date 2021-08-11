function PlayerKnuxGlide()
{
	// Exit if we've died
	if Death or Drown
	{
		exit;
	}
	
	// Exit the code if we're not in glide state
	if !GlideState
	{
		exit;
	}
	
	// Air glide
	if GlideState == GlideActive and !GlideGrounded
	{
		// Check if action button is held
		if Input.ABC
		{
			// Set 'glide' animation
			Animation = AnimGlide;
		
			// Apply gravity
			Grv = Ysp < 0.5 ? 0.125 : -0.125;
		
			// Glide to the left
			if GlideDirection = DirectionLeft
			{	
				// Check if we're turning from right
				if GlideValue > 0
				{
					GlideValue -= 2.8125;		
					Xsp			= GlideSpeed * dcos(GlideValue) * -sign(GlideSpeed);
				}
				
				// Glide stright
				else
				{
					Xsp = max(Xsp - GlideAcc, -24);
				}
					
				// Start turn to the right
				if Input.RightPress
				{
					if GlideValue == 0
					{
						GlideSpeed = Xsp;
					}
					GlideDirection = DirectionRight;
				}
			}
		
			// Glide to the right
			else if GlideDirection == DirectionRight
			{	
				// Check if we're turning from left
				if GlideValue < 180
				{
					GlideValue += 2.8125;
					Xsp			= GlideSpeed * dcos(GlideValue) * -sign(GlideSpeed);
				}
				
				// Glide stright
				else
				{
					Xsp = min(Xsp + GlideAcc, 24);
				}
				
				// Start turn to the left
				if Input.LeftPress
				{	
					if GlideValue == 180
					{
						GlideSpeed = Xsp;
					}
					GlideDirection = DirectionLeft;
				}
			}
		
			// Define facing direction
			Facing = GlideValue > 90 ? DirectionRight : DirectionLeft;
		
			// Define animation frame
			if GlideValue < 119.53
			{
				if GlideValue > 60.47
				{
					GlideFrame = 3;
				}
				else if GlideValue > 30.94
				{
					GlideFrame = 2;
				}
				else
				{
					GlideFrame = 1;
				}
			}
			else if GlideValue < 149.065
			{
				GlideFrame = 2;
			}		
			else
			{
				GlideFrame = 1;
			}
		}
	
		// If action button is not held anymore
		else
		{
			// Lower horizontal speed
			Xsp *= 0.25;
		
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
			
			// Restore default radiuses
			RadiusX	= DefaultRadiusX;
			RadiusY	= DefaultRadiusY;
			
			// Enter drop state
			GlideState = GlideDrop;
			
			// Animation
			Animation = AnimGlideDrop;
		}
	}
	
	// Check for walls
	var LeftDistance  = tile_check_collision_h(floor(PosX - 10), floor(PosY), false, true, Layer)[0];
	var RightDistance = tile_check_collision_h(floor(PosX + 10), floor(PosY), true, true,  Layer)[0];
			
	// Are we colliding with wall?
	if LeftDistance < 0 or RightDistance < 0
	{
		if LeftDistance < 0
		{
			PosX -= LeftDistance;
		}
		else if RightDistance < 0
		{
			PosX += RightDistance;
		}
		Xsp = 0;
		
		if GlideState == GlideActive and !GlideGrounded
		{
			Ysp = 0;
			
			RadiusY = DefaultRadiusY;
			
			GlideState = false;
			ClimbState = true;
			
			audio_sfx_play(sfxGrab, false);
		}	
	}
			
	// If we're not colliding walls, try floor or ceiling collision
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
		}
				
		// If we're not touching the ceiling, do floor collision if we're moving downwards
		else if Ysp >= 0
		{
			// Check for floor
			var TileLeft  = tile_check_collision_v(floor(PosX - RadiusX), floor(PosY + RadiusY), true, false, Layer);
			var TileRight = tile_check_collision_v(floor(PosX + RadiusX), floor(PosY + RadiusY), true, false, Layer);
				
			// Get nearest tile
			var NearestTile = tile_check_nearest(TileLeft, TileRight, noone);
					
			// Get data
			var FloorDistance = NearestTile[0];
			var FloorAngle    = NearestTile[1];
			
			// Are we not sliding yet?
			if !GlideGrounded
			{	
				// Are we not in stop state?
				if GlideState != GlideStop
				{
					// Are we touching the floor?
					if FloorDistance < 0
					{
						// Reset vertical speed
						Ysp = 0;
						Grv = 0;
				
						// Is floor shallow enough?
						if FloorAngle <= 45 or FloorAngle >= 315
						{
							// Enter ground glide state if gliding
							if GlideState == GlideActive
							{
								GlideValue    = 16;
								GlideGrounded = true;
								
								audio_sfx_play(sfxSlide, true);
								
								// Create dust effect
								instance_create(floor(PosX), floor(PosY + RadiusY), DustPuff);
							}
				
							// Enter stop state if dropping
							else if GlideState == GlideDrop
							{
								// Adhere to the surface
								PosY += FloorDistance;
								
								GlideState = GlideStop;
								GlideValue = 16;
								Xsp	       = 0;
								
								audio_sfx_play(sfxLand, false);
							}
						}
				
						// Just land on a steeper floor
						else
						{
							// Use full vertical speed on full steep floor
							Xsp		= 0;
							Inertia = FloorAngle < 180 ? -Ysp : Ysp;
					
							// Inherit floor angle
							Angle = FloorAngle;
				
							// Set flag
							Grounded = true;
						}
					}
				}
		
				// Are we in stop state? (check at the very same frame)
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
	
			// Are we sliding? (check at the very same frame)
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
		
				// Check if ground is far too away below us
				if FloorDistance > 14
				{
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
			
					// Set animation
					Animation = AnimGlideDrop;
			
					// Enter drop state
					GlideGrounded = false;
					GlideState    = GlideDrop;
			
					// Restore default radiuses
					RadiusX	= DefaultRadiusX;
					RadiusY	= DefaultRadiusY;
					
					audio_sfx_stop(sfxSlide);
				}
				else
				{		
					// Adhere to the surface
					PosY += FloorDistance;
					
					// Slide until we stop or release jump button
					if Xsp == 0 or !Input.ABC
					{
						// Change state
						GlideState = GlideStop;
			
						// Land
						if !(--GlideValue)
						{
							Angle    = FloorAngle;
							Grounded = true;
						}
			
						// Set animation
						Animation = AnimGlideStand;
			
						// Correct our position and restore default radiuses
						PosY   -= DefaultRadiusY - RadiusY;
						RadiusX = DefaultRadiusX;
						RadiusY = DefaultRadiusY;
			
						// Reset speed
						Xsp	= 0;	
					
						audio_sfx_stop(sfxSlide);
					}
				}
			}
			
			// If in stop state, check for jumping
			if GlideState == GlideStop
			{
				if Input.ABCPress
				{	
					// Do not jump if found the low ceiling
					if Angle <= 45 or Angle >= 315
					{
						if tile_check_collision_v(floor(PosX - RadiusX), floor(PosY - RadiusY), false, true, Layer)[0] < 6
						or tile_check_collision_v(floor(PosX + RadiusX), floor(PosY - RadiusY), false, true, Layer)[0] < 6
						{
							exit;
						}
					}
					
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
					
					// Set speeds
					Xsp  += Jump * dsin(Angle);
					Ysp	 += Jump * dcos(Angle);	
		
					// Update flags
					Jumping    = true;
					Grounded   = false;
					GlideState = false;
					GlideValue = false;
					GlideSlide = false;
		
					// Update radiuses
					PosY   += RadiusY - SmallRadiusY;
					RadiusY = SmallRadiusY;
					RadiusX	= SmallRadiusX;
							
					// Set animation
					Animation = AnimRoll;
		
					// Play sound
					audio_sfx_play(sfxJump, false);
				}
			}
		}
	}
}