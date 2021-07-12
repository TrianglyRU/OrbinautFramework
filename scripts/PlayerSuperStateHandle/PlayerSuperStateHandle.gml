function PlayerSuperStateHandle()
{
	if Death
	{
		exit;
	}
	
	/* SuperStateValue is handled automatically, all you have to use to toggle is
	SuperState = true or SuperState = false
	*/
	
	// Transform
	if !SuperState
	{
		if Jumping and Ysp <= 0 and !SuperStateValue and Input.ABCPress
		{
			Jumping		    = false;
			SuperState	    = true;
			SuperStateValue = 0;
			
			xRadius = xRadiusDefault;
			yRadius = yRadiusDefault;
			
			audio_sfx_play(sfxTransform, false);
		}
	}
	
	// Handle superform
	switch SuperState
	{	
		// Transformation start
		case 1:
		{
			// Start timer
			SuperStateValue++
			
			// Reset speeds
			Inertia = 0;
			Xsp		= 0;
			Ysp		= 0;
		
			// Play animation
			Animation = AnimTransform;
			
			// Make us invincible
			IsInvincible = true;
			
			// Become super after 24 frames
			if SuperStateValue == 25
			{
				// Exit transform animation
				Animation = AnimWalk;
				
				SuperState		= 2;
				SuperStateValue = -1;
			}				
		}
		break;
		
		// Superform
		case 2:
		{
			// Keep us invincible
			IsInvincible = true;

			// Decrease rings
			if Rings
			{
				SuperStateValue--
				
				if SuperStateValue == -61
				{
					SuperStateValue = -1;
					Rings--;
				}
			}
			
			// Exit superform
			if !Rings or Jumping and Input.CPress
			{
				SuperStateValue = 1;
				SuperState		= false;
				
				audio_sfx_play(sfxTransform, false);
			}
		}
		break;
		
		// De-transform
		case 0:
		{	
			if SuperStateValue < 0
			{
				SuperStateValue = 0;
			}
			
			// Start timer
			SuperStateValue++
			
			// Become regylar after 24 frames
			if SuperStateValue == 25
			{
				SuperState		= -1;
				SuperStateValue = 0;
			}
		}
		break;		
	}
}