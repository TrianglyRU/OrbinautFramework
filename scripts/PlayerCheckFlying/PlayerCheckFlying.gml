function PlayerCheckFlying()
{
	// Check if we're Tails
	if CharacterID != CharTails exit;
	
	if !Flying
	{	
		// Enter flying state
		if Jumping and Input.ABCPress
		{
			Grv			= 0.03125;
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
			Animation = AnimFly;
			
			// Decrease timer
			FlyingTimer--;
			
			// Temporary decrease gravity
			if (Input.ABCPress) Grv = -0.125;
		
			// Increase gravity when moving slow enough or detected a ceiling
			if Ysp < -1 or tile_meeting(floor(PosX - xRadius), floor(PosY - yRadius - 1), Layer)
					    or tile_meeting(floor(PosX + xRadius), floor(PosY - yRadius - 1), Layer)
			{
				Grv = 0.03125;
			}
		}
		
		// Else enter "tired" state
		else
		{
			Animation = AnimFlyTired;
			Flying    = 2;
			Grv		  = 0.03125;
		}
	}
	
	show_debug_message(Grv);
}