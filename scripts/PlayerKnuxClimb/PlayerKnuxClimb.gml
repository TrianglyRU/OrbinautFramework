function PlayerKnuxClimb()
{
	// Exit if not climbing
	if !ClimbState
	{
		exit;
	}
	   
	// Climb on walls
	if ClimbState == 1
	{
		// Set animation
		Animation = AnimClimb;
		
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
		
		// Collide with ceiling
		if Ysp < 0
		{
			var RoofDistance = tile_check_collision_v(floor(PosX + RadiusX * Facing), floor(PosY - RadiusY), false, true, Layer)[0];	
			if  RoofDistance < 0
			{	
				PosY -= RoofDistance;
				Ysp   = 0;
			}
		}
	
		// Collide with floor
		else
		{
			var FloorDistance = tile_check_collision_v(floor(PosX + 10 * Facing), floor(PosY + RadiusY), true, false, Layer)[0];	
			if  FloorDistance < 0
			{	
				// Reset collision radiuses
				RadiusX = DefaultRadiusX;
				RadiusY = DefaultRadiusY;
				
				// Clip out and land
				PosY    += FloorDistance;
				Grounded = true;
				Ysp      = 0;
				
				// Exit the code
				exit;
			}
		}
		
		// Check for walls
		var DistanceAbove = tile_check_collision_h(floor(PosX + RadiusX * Facing), floor(PosY - 10), Facing, true, Layer)[0];
		var DistanceBelow = tile_check_collision_h(floor(PosX + RadiusX * Facing), floor(PosY + 10), Facing, true, Layer)[0];
		
		// Check if there is no wall in front of us
		if DistanceBelow > 0
		{
			// Reset collision radiuses
			RadiusX = DefaultRadiusX;
			RadiusY = DefaultRadiusY;
			
			// Set flags
			ClimbState = false;
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
		}
		
		// Check if we're near the edge to climb on it
		else if DistanceAbove > 0
		{
			ClimbState     = 2;
			Ysp		       = 0;
			AllowCollision = false;
		}
				
		// Jump if we pressed action button
		else if Input.ABCPress
		{
			// Set flags
			Facing	  *= -1;
			Jumping	   = true;
			ClimbState = false;
			Animation  = AnimRoll;
			
			// Set speeds
			Ysp	= -4;
			Xsp	=  4 * Facing;
			
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
		
	// Check if we're climbering on the edge
	if ClimbState == 2
	{
		// Adjust positons
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
				PosY -= DefaultRadiusY - RadiusY;
				
				// Land
				AllowCollision = true;
				Grounded	   = true;
			}
			break;
		}
		
		// Set vertical speed and animation
		Ysp		  = 0;
		Animation = AnimClimbering;
	}
}