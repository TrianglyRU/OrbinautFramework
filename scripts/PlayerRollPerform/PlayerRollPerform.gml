function PlayerRollPerform()
{
	// You are not able to roll if any of side direction buttons are pressed
	if Input.Left or Input.Right or Jumping exit
	
	// Start rolling
	if abs(Xsp) >= 0.5 
	{
		if Input.Down 
		{	
			// Update radiuses and adjust position
			yRadius = yRadiusRoll;
			xRadius	= xRadiusRoll;
			PosY   += yRadiusDefault - yRadiusRoll;
			Rolling = true;
			
			// Set animation
			Animation = AnimRoll;
		}
	}	
}