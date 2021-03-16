function PlayerCheckFlying()
{
	// Check if we're Tails
	if CharacterID != CharTails exit;
	
	if !Flying
	{	
		// Enter flying state
		if Jumping and Input.ABCPress
		{
			Flying		= true;
			FlyingTimer = 480;
			Jumping		= false;
		}
	}
	else if Flying != 2
	{	
		// Keep flying while timer is greater than 0
		if FlyingTimer > 0
		{
			// Decrease timer
			FlyingTimer--;
			
			// Temporary decrease gravity
			if (Input.ABCPress) Grv = -0.125;
		
			// Increase gravity when moving slow enough
			if Ysp < -1
			{
				Grv = 0.03125;
			}
		}
		
		// Else enter "tired" state
		else
		{
			Flying = 2;
		}
	}
		
}