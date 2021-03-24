function PlayerCheckGlide()
{
	// Check if we're Knuckles
	if CharacterID != CharKnuckles exit;
	
	// Airborne code
	if !Grounded
	{
		// Start gliding
		if !Gliding
		{
			if Jumping and Input.ABCPress
			{
				Jumping = false;
				Gliding = true;
				Xsp     = 4 * Facing;
				if (Ysp < 0) Ysp = 0;
			
				// Set default turn value
				if Facing = FacingRight
				{
					GlidingTurn = 0;
				}
				else
				{
					GlidingTurn = -180;
				}
			}
		}
	
		// Glide
		else if Gliding < 3
		{
			if Input.ABC
			{
				// Set animation
				Animation = AnimGlide;
			
				// Check if we want to turn to another direction
				if Xsp > 0 and Input.LeftPress 
				or Xsp < 0 and Input.RightPress
				{
					Inertia = Xsp;
					Gliding = 2;
				}
				if Gliding = 2
				{
					GlidingTurn += 2.8125 * -sign(Inertia);	
					Xsp	= Inertia * Facing * dcos(GlidingTurn);
				
					if GlidingTurn = -180 or GlidingTurn = 0
					{
						Gliding = 1;
						Facing  *= -1;
					}
				}
			
				// Accelerate when we're not turning
				if Gliding = 1
				{
					Xsp += Facing * 0.015625;
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
				
				Xsp	   *= 0.25;
				Grv		= 0.21875;
				Gliding = 3;
			}
		}	
	}
	
	// Ground code
	else if Gliding = 1
	{
		Animation = AnimGlide;
			
		Frc			 = 0.125;
		MovementLock = -1;
			
		// Glide on our belly until we release button or completely stop
		if (!Input.ABC) or Inertia = 0
		{
			Inertia		 = 0;
			Xsp			 = 0;
			Gliding		 = false;
			MovementLock = false;
			Frc			 = 0.046875;
		}
	}
}