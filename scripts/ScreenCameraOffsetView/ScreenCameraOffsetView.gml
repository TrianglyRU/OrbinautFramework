function ScreenCameraOffsetView()
{	
	// Update camera lag delay timer
	if (ScrollDelay > 0) ScrollDelay--;
	
	// Update extended camera offset
	if Game.ExtendedCamera
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
	
	// Set ATS Shift
	ATSShift = ATSShift + (Player.Inertia * 4 - ATSShift) * 0.1;
	ATSShift = 0;
		
	// Set vertical spin offset
	if Player.Rolling or (Player.Jumping and Player.Rolling)
	{
		SpinOffset = Player.yRadiusDefault - Player.yRadiusRoll;
	} 
	else 
	{
		SpinOffset = 0;
	}
	
	// Set up/down shift varaible
	var ShiftDown = Player.Animation == AnimCrouch;
	var ShiftUp   = Player.Animation == AnimLookup;
	
	// Delay up/down shift if spindash or peelout is enabled
	if Game.SpindashEnabled or Game.PeeloutEnabled
	{
		if ShiftUp or ShiftDown
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
		if ShiftDown and OverviewOffset < 88 
		{
			OverviewOffset += 2;
		}
		if ShiftUp and OverviewOffset > -104 
		{
			OverviewOffset -= 2;
		} 		
	} 	
	
	// Shift back to original position
	if !ShiftUp and !ShiftDown and OverviewOffset != 0
	{
		OverviewOffset -= 2 * sign(OverviewOffset);
	}	
}