function ScreenCameraOffsetView()
{	
	// Update camera lag delay timer
	if (ScrollDelay > 0) ScrollDelay--;
	
	// Update extended camera offset
	if Game.ExtendedCamera = true 
	{
		if abs(Player.Xsp) >= Player.TopAcc 
		{
			if abs(ExtendedOffset) < 64 
			{
				ExtendedOffset += 2 * sign(Player.Xsp);
			}
		} 
		else 
		{
			ExtendedOffset -= 2 * sign(ExtendedOffset);
		}
	}
	
	// Set vertical spin offset
	if Player.Rolling or (Player.Jumping and Player.Rolling) 
	{
		SpinOffset = Player.yRadiusDefault - Player.yRadiusRoll;
	} 
	else 
	{
		SpinOffset = 0;
	}
	
	// Set camera overview delay and offset
	var CHAR_LOOK_UP   = Player.Inertia = 0 and  Input.Up and Player.SpindashRev < 0 and Player.Grounded;
	var CHAR_LOOK_DOWN = Player.Inertia = 0 and !Input.Up and Input.Down and Player.SpindashRev < 0 and Player.Grounded;
	
	if Game.SpindashEnabled = true 
	{
		if CHAR_LOOK_UP or CHAR_LOOK_DOWN 
		{
			if (OverviewDelay > 0) OverviewDelay--;
		} 
		else 
		{
			OverviewDelay = 120;
		}
	} 
	else 
	{
		OverviewDelay = 0;
	}
	if OverviewDelay = 0 
	{
		if CHAR_LOOK_DOWN and OverviewOffset < 88 
		{
			OverviewOffset += 2;
		}
		if CHAR_LOOK_UP and OverviewOffset > -104 
		{
			OverviewOffset -= 2;
		} 		
	} 	
	if !CHAR_LOOK_UP and !CHAR_LOOK_DOWN and OverviewOffset != 0
	{
		OverviewOffset -= 2 * sign(OverviewOffset);
	}	
}