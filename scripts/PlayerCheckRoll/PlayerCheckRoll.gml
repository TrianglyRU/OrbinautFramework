function PlayerCheckRoll()
{
	// You are not able to roll if side direction button is pressed
	if Input.Left or Input.Right exit
	
	// Start rolling
	if abs(Xsp) >= 0.5 
	{
		if Input.Down 
		{	
			// Update radiuses
			yRadius   = yRadiusRoll;
			xRadius	  = xRadiusRoll;
			PosY     += yRadiusDefault - yRadiusRoll;
			Rolling   = true;
			
			// Set animation
			Animation = AnimRoll;
			
			// Play sound
			audio_sfx_play(sfxRoll, false);
		}
	}	
}