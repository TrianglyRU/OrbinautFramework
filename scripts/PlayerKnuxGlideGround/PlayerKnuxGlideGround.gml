function PlayerKnuxGlideGround()
{
	// Exit if collisions are disabled
	if !AllowCollision
	{
		exit;
	}
	
	// Exit if we're not gliding
	if !GlideState
	{
		exit;
	}
	
	/* Knuckles glide code completely overrides air collision code,
	   so AirLevelCollision is not performed */
	
	// Check left or right wall
	var WallDistance = tile_check_collision_h(floor(PosX + 10 * Facing), floor(PosY), Facing, true, Layer)[0];
	if  WallDistance < 0
	{
		// Collide if distance is less than 0
		PosX += WallDistance * Facing;
		Xsp   = 0;
	}
	
	// If moving upwards, exit
	if Ysp < 0
	{
		exit;
	}
	
	// Check for floor
	var FloorLeft  = tile_check_collision_v(floor(PosX - RadiusX), floor(PosY + RadiusY), true, false, Layer);
	var FloorRight = tile_check_collision_v(floor(PosX + RadiusX), floor(PosY + RadiusY), true, false, Layer);
				
	// Get nearest floor
	var NearestFloor = tile_check_nearest(FloorLeft, FloorRight, noone);
					
	// Get data
	var FloorDistance = NearestFloor[0];
	var FloorAngle    = NearestFloor[1];
	
	// Are we not sliding yet?
	if !GlideGrounded
	{	
		// Are we not in stop state?
		if GlideState != GlideStop
		{
			// Are we touching the floor?
			if FloorDistance < 0
			{
				// Adhere to the surface
				PosY += FloorDistance;
				Ysp   = 0;
				
				// Disable gravity
				Grv = 0;
				
				// Set slide flag if we're gliding
				if GlideState == GlideActive
				{
					GlideValue    = 0;
					GlideGrounded = true;
				}
				
				// Set stop flag if we're dropping
				else if GlideState == GlideDrop
				{
					GlideState = GlideStop;
					GlideValue = 16;
					Xsp	       = 0;
				}	
			}
		}
		
		// Are we in stop state?
		else
		{
			// Land
			if !GlideValue
			{
				Angle    = FloorAngle;
				Grounded = true;
			}
			
			// Decrease timer
			else
			{
				GlideValue--;
			}
			
			// Set animation
			Animation = AnimDropStand;
		}
	}
	
	// Are we sliding?
	else
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
			GlideState = GlideDrop;
			
			// Restore default radiuses
			RadiusX	= DefaultRadiusX;
			RadiusY	= DefaultRadiusY;	
		}
		
		// Adhere to the surface
		else
		{		
			PosY += FloorDistance;
		}
		
		// Slide until we stop or release jump button
		if Xsp == 0 or !Input.ABC
		{
			// Change state
			if GlideState != GlideStop
			{
				GlideState = GlideStop;
				GlideValue = 16;
			}
			
			// Land
			if !GlideValue
			{
				Angle    = FloorAngle;
				Grounded = true;
			}
			
			// Decrease timer
			else
			{
				GlideValue--;
			}
			
			// Set animation
			Animation = AnimGlideStand;
			
			// Correct our position and restore default radiuses
			PosY   -= DefaultRadiusY - RadiusY;
			RadiusX = DefaultRadiusX;
			RadiusY = DefaultRadiusY;
			
			// Reset speed
			Xsp	= 0;	
		}
		else
		{
			// 4 frames passed?
			if GlideValue mod 4 == 0
			{	
				// Create dust effect
				instance_create(floor(PosX), floor(PosY + RadiusY), DustPuff);
			
				// Reset value
				GlideValue = 0;
			}
			
			// Increase timer
			GlideValue++
		}
	}
}