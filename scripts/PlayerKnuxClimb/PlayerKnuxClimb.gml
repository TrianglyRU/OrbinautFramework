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
		Animation = AnimClimb;
		
		// Collide with ceiling
		if Ysp < 0
		{
			var RoofDistance = tile_check_collision_v(PosX + RadiusX * Facing, PosY - RadiusY, false, true, Layer)[0];	
			if  RoofDistance < 0
			{	
				PosY -= RoofDistance;
			}
		}
	
		// Collide with floor
		else if Ysp > 0
		{
			var FloorDistance = tile_check_collision_v(PosX + 10 * Facing, PosY + RadiusY, true, false, Layer)[0];
			if  FloorDistance < 0
			{
				PosY    += DistanceDown;
				Grounded = true;
				Ysp		 = 0;
				
				// Exit further code
				exit;
			}
		}
		
		// Drop if no wall found in front of us
		var WallDistance = tile_check_collision_h(PosX + RadiusX * Facing, PosY + 10, Facing, true, Layer)[0];
		if  WallDistance > 0
		{
			ClimbState = false;
			GlideState = GlideDrop;	
			Animation  = AnimClimbDrop;
					
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
			
			// Exit further code
			exit;
		}
		
		// If near the edge, start climbering
		var EdgeDistance = tile_check_collision_h(PosX + RadiusX * Facing, PosY - 10, Facing, true, Layer)[0];
		if  EdgeDistance
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
		
	// Climb on the edge
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