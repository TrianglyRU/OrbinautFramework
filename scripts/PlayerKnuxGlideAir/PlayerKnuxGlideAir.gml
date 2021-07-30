function PlayerKnuxGlideAir()
{
	// Exit the code if we've died
	if Death or Drown
	{
		exit;
	}
	
	// Exit the code if we're not in glide state or we're sliding on the ground
	if !GlideState or GlideGrounded
	{
		exit;
	}
	
	// Check left or right wall
	var WallData = tile_check_collision_h(floor(PosX + 10 * Facing), floor(PosY), Facing, true, Layer);
	if  WallData[0] < 0
	{
		// Collide if distance is less than 0
		PosX += WallData[0] * Facing;
		Xsp   = 0;
		
		// Are we gliding?
		if GlideState == GlideActive
		{	
			// Is it flat wall?
			if WallData[1] mod 90 == 0
			{	
				// Reset vertical speed
				Ysp = 0;
						
				// Enter climbing state
				GlideState = false;
				ClimbState = true;
			}
			
			// If not, drop
			else
			{
				show_debug_message("Kok!");
				
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
	}
	
	// If we're not touching the wall, try ceiling collision
	else if !(abs(Xsp) < abs(Ysp) and Ysp > 0)
	{
		// Check for ceiling
		var RoofLeft  = tile_check_collision_v(floor(PosX - RadiusX), floor(PosY - RadiusY), false, true, Layer);
		var RoofRight = tile_check_collision_v(floor(PosX + RadiusX), floor(PosY - RadiusY), false, true, Layer);
				
		// Get nearest tile
		var NearestRoof = tile_check_nearest(RoofLeft, RoofRight, noone);
				
		// Get data
		var RoofDistance = NearestRoof[0];
		var RoofAngle    = NearestRoof[1];
			
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
	}

	// Exit the code if we're not in active glide state
	if GlideState != GlideActive
	{
		exit;
	}
	
	// Set 'glide' animation
	Animation = AnimGlide;
	
	// Check if action button is held
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
	
	// If action button is not held
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