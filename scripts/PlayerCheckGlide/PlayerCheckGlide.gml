function PlayerCheckGlide()
{
	// Check if we're Knuckles
	if CharacterID != CharKnuckles exit;
	
	// Check if we're airborne
	if !Grounded
	{	
		// Start gliding
		if !GlidingState
		{
			if Jumping and Ysp > -4 and Input.ABCPress
			{
				// Set speeds
				if (Ysp < 0) Ysp = 0;
				Xsp	= 4 * Facing;

				// Set unique gliding radiuses
				xRadius = 10;
				yRadius = 10;
			
				// Set gliding angle value
				if Facing == DirRight
				{
					GlidingValue = 0;
				}
				else
				{
					GlidingValue = -180;
				}
				
				// Enter gliding state
				Jumping		 = false;
				GlidingState = 1;
			}
		}
	
		// Glide
		else if GlidingState < 3 and Input.ABC
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
				
			// Accelerate while we're not turning
			if GlidingState == 1
			{
				Xsp += Facing * 0.015625;
			}
				
			// Perform turn (TODO: Rewrite this code)
			if GlidingState == 2
			{
				GlidingValue += 2.8125 * -sign(Inertia);	
				Xsp	= Inertia * Facing * dcos(GlidingValue);
				
				if GlidingValue == -180 or GlidingValue == 0
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
			Animation	 = AnimGlideDrop;
			Xsp		    *= 0.25;
			Grv			 = 0.21875;
			GlidingState = 3;	
			xRadius		 = xRadiusDefault;
			yRadius		 = yRadiusDefault;
		}
	}
	
	// Check if we're on the ground
	else 
	{
		// Check if we're gliding
		if GlidingState == 1
		{
			// Set animation
			Animation = AnimGlideSlide;
		
			// Glide until we release the button or completely stop
			if !Input.ABC or Inertia == 0
			{	
				GlidingValue = 20;
				GlidingState = 4;		
			}
		}
		
		// Check if we stopped gliding
		else if GlidingState == 4
		{
			// Set animation
			Animation = AnimGlideStand;
			
			// Reset speeds
			Inertia = 0;
			Frc		= 0.046875;
			
			// Reset radiuses
			yRadius = yRadiusDefault; 
			xRadius	= xRadiusDefault;
			
			// Leave gliding state when timer runs out
			if GlidingValue != 0
			{
				GlidingValue--;
			}
			else
			{
				MovementLock = false;
				GlidingState = false;
			}
		}
	}
}