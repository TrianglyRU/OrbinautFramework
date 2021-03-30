function ScreenCameraOffsetView()
{	
	// Update camera lag delay timer
	if (ScrollDelay > 0) ScrollDelay--;
	
	// Update extended camera offset
	if Game.ExtendedCamera == true
	{
		if abs(Player.Inertia) >= 6 or Player.PeeloutRev >= 16 or Player.SpindashRev >= 0
		{
			if abs(ExtendedOffset) < 64 and ScrollDelay == 0
			{
				if abs(Player.Inertia) >= 6
				{
					ExtendedOffset += 2 * sign(Player.Xsp);
				}
				else if Player.PeeloutRev >= 16 or Player.SpindashRev >= 0
				{
					ExtendedOffset += 2 * Player.Facing;
				}
			}
		}
		else
		{
			ExtendedOffset -= 2 * sign(ExtendedOffset);
		}	
	}
		
	// Set vertical spin offset
	if Player.Rolling == true or (Player.Jumping and Player.Rolling) == true
	{
		SpinOffset = Player.yRadiusDefault - Player.yRadiusRoll;
	} 
	else 
	{
		SpinOffset = 0;
	}
	
	// Set up/down shift varaible
	var ShiftDown = Player.Inertia == 0 and Input.Down and Player.SpindashRev < 0 and Player.Grounded == true;
	var ShiftUp   = Player.Inertia == 0 and Input.Up   and Player.PeeloutRev  < 0 and Player.Grounded == true;
	
	// Delay up/down shift if spindash or peelout is enabled
	if Game.SpindashEnabled == true or Game.PeeloutEnabled == true
	{
		if ShiftUp == true or ShiftDown == true
		{
			if (OverviewDelay > 0) OverviewDelay--;
		} 
		else if OverviewOffset == 0
		{
			OverviewDelay = 120;
		}
	} 
	else 
	{
		OverviewDelay = 0;
	}
	
	// Shift up/down
	if OverviewDelay == 0
	{
		if ShiftDown == true and OverviewOffset < 88 
		{
			OverviewOffset += 2;
		}
		if ShiftUp == true and OverviewOffset > -104 
		{
			OverviewOffset -= 2;
		} 		
	} 	
	
	// Shift back to original position
	if ShiftUp == false and ShiftDown == false and OverviewOffset != 0
	{
		OverviewOffset -= 2 * sign(OverviewOffset);
	}	
}