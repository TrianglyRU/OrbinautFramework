function PlayerCheckGlide()
{
	// Check if we're Knuckles
	if CharacterID != CharKnuckles exit;
	
	// Airborne code
	if !Grounded
	{
		// Start gliding
		if GlidingState = false
		{
			if Jumping and Ysp > -4 and Input.ABCPress
			{
				Xsp			 = 4 * Facing;
				Jumping		 = false;
				GlidingState = 1;
				if (Ysp < 0) Ysp = 0;
			
				// Set default turn value
				if Facing = FacingRight
				{
					GlidingDirection = 0;
				}
				else
				{
					GlidingDirection = -180;
				}
			}
		}
	
		// Glide
		else if GlidingState < 3
		{
			if Input.ABC
			{
				// Set animation
				Animation = AnimGlide;
			
				// Check if we want to turn to another direction
				if Xsp > 0 and Input.LeftPress 
				or Xsp < 0 and Input.RightPress
				{
					Inertia		 = Xsp;
					GlidingState = 2;
				}
				
				// Accelerate when we're not turning
				if GlidingState = 1
				{
					Xsp += Facing * 0.015625;
				}
				
				// Turn
				if GlidingState = 2
				{
					GlidingDirection += 2.8125 * -sign(Inertia);	
					Xsp	= Inertia * Facing * dcos(GlidingDirection);
				
					if GlidingDirection = -180 or GlidingDirection = 0
					{
						GlidingState =  1;
						Facing		*= -1;
					}
				}

				// Apply gravity
				if Ysp < 0.5
				{
					Grv = 0.125;
				}
				else
				{
					Grv = -0.125;
				}
			}
		
			// Fall on button release
			else
			{
				Animation = AnimGlideDrop;
				
				Xsp		    *= 0.25;
				Grv			 = 0.21875;
				GlidingState = 3;
			}
		}	
	}
	
	// Ground code
	else if GlidingState = 1
	{
		// Set animation
		Animation = AnimGlideSlide;
		
		// Glide on our belly until we release button or completely stop
		if (!Input.ABC) or Inertia = 0
		{
			Inertia		 = 0;
			Xsp			 = 0;
			GlidingState = false;
			MovementLock = false;
			Frc			 = 0.046875;
		}
	}
}