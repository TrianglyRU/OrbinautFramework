function PlayerCheckRoll()
{
	// You are not able to roll if side direction button is pressed
	if Input.Left or Input.Right exit
	
	// Start rolling
	if abs(Xsp) >= 0.5 
	{
		if Input.Down 
		{	
			// Update radiuses (we do not adjust position, tile collision will do this automatically)
			yRadius   = yRadiusRoll;
			xRadius	  = xRadiusRoll;
			Rolling   = true;
			
			// Set animation
			Animation = AnimRoll;
			
			// Play sound
			audio_sfx_play(sfxRoll, false);
		}
	}	
}