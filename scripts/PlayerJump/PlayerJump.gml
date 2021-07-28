function PlayerJump()
{
	// Exit if we're not jumping
	if !Jumping
	{
		exit;
	}
	
	// Shorten our jump force
	if !Input.ABC
	{
		if Ysp < JumpMin
		{
			Ysp = JumpMin;
		}
	}	
	
	// Check if action button was pressed
	if Input.ABCPress
	{		
		// Reset jump and roll flag
		Jumping = false;
		Rolling = false;
		
		// Check if we have 50 rings and 7 emeralds
		if Rings >= 50 and Emeralds == 7
		{
			// Transform
			SuperState = true;
		}
		
		// Else perform character action
		else switch CharacterID
		{
			// Start flight
			case CharTails:
			{
				// Use normal collision radiuses
				RadiusX = DefaultRadiusX;
				RadiusY = DefaultRadiusY;
				
				// Set gravity
				Grv = 0.03125;
				
				// Set timer
				FlightValue = 480;
				
				// Enter flight state
				FlightState = FlightActive;
				
				// Clear action inputs
				Input.ABC	   = false;
				Input.ABCPress = false;
			}
			break;
			
			// Start glide
			case CharKnuckles:
			{
				// Set unique glide radiuses
				RadiusX = 10;
				RadiusY = 10;
				
				// Reset vertical speed and inertia		
				Ysp     = max(Ysp, 0);
				Inertia = 0;
				
				// Set gravity
				Grv = 0.125;
				
				// Set horizontal speed
				Xsp = 4 * Facing;
				
				// Set glide direction
				if Facing == DirectionRight
				{
					GlideDirection = DirectionRight;
					GlideValue	   = 180;
				}
				else if Facing == DirectionLeft
				{
					GlideDirection = DirectionLeft;
					GlideValue	   = 0;
				}
				
				// Enter glide state
				GlideState    = GlideActive;
				GlideGrounded = false;
			}
			break;
		}
	}
}