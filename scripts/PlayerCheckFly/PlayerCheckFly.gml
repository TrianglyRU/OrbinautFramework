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
	else if FlyingState != 2
	{	
		// Keep flying while timer is greater than 0
		if FlyingTimer > 0
		{
			Animation = AnimFly;
			
			// Decrease timer
			FlyingTimer--;
			
			// Temporary decrease gravity
			if (Input.ABCPress) Grv = -0.125;
		
			// Increase gravity when moving slow enough or detected a ceiling
			if (Ysp < -1) Grv = 0.03125;
			
			// Cancel
			if Game.FlyingCancel and Input.CPress
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
		
		// Else enter "tired" state
		else
		{
			Animation   = AnimFlyTired;
			FlyingState = 2;
			Grv		    = 0.03125;
		}
	}
}