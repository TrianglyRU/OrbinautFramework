function PlayerCheckFly()
{
	// Check if we're Tails
	if CharacterID != CharTails exit;
	
	// Enter flying state
	if FlyingState = false
	{	
		if Jumping and Ysp > -4 and Input.ABCPress
		{
			Grv			= 0.03125;
			FlyingState = 1;
			FlyingTimer = 480;
			Jumping		= false;
		}
	}
	
	// Fly time!
	else
	{	
		if FlyingTimer > 0
		{
			// Decrease timer
			FlyingTimer--;
				
			// Temporary decrease gravity
			if (Input.ABCPress) Grv = -0.125;
		
			// Increase gravity when moving slow enough
			if (Ysp < -1) Grv = 0.03125;
			
			// Set animation
			Animation = AnimFly;
			
			// Cancel
			if Game.FlyingCancel and Input.Down and Input.ABCPress 
			{
				FlyingState	= false;
				FlyingTimer = 0;
				Grv		    = 0.21875;
				Rolling		= true;
				Animation   = AnimRoll;
				
				// Since we're going the into rolling state, rolling offset will be applied to the camera.
				// So let's correct its position
				Screen.ViewY += xRadiusDefault - xRadiusRoll;
			}		
		}
		
		// Enter "tired" state
		else
		{
			Animation   = AnimFlyTired;
			FlyingState = 2;
			Grv		    = 0.03125;
		}
	}
}