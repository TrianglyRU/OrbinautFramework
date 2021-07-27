function ScreenCameraHandleOffsets()
{	
	// Exit if paused
	if Stage.GamePaused
	{
		exit;
	}
	
	// Update extended camera offset
	if Game.ExtendedCamera
	{
		var ScreenShift = Screen.Width / 2 - 96;
		var ScreenSpeed = floor(ScreenShift / 32);
		
		if abs(Player.Inertia) >= 6 or Player.PeeloutRev >= 16 or Player.SpindashRev >= 0
		{
			if abs(ExtendedOffset) < ScreenShift and ScrollDelay == 0
			{
				if abs(Player.Inertia) >= 6
				{
					ExtendedOffset += ScreenSpeed * sign(Player.Xsp);
				}
				else if Player.PeeloutRev >= 16 or Player.SpindashRev >= 0
				{
					ExtendedOffset += ScreenSpeed * Player.Facing;
				}
			}
		}
		else
		{
			ExtendedOffset -= ScreenSpeed * sign(ExtendedOffset);
		}
	}
	
	// Set vertical spin offset
	if Player.Rolling or (Player.Jumping and Player.Rolling)
	{
		SpinOffset = Player.DefaultRadiusY - Player.SmallRadiusY;
	} 
	else 
	{
		// Shift camera back if offset is active, but we're airborne and not rolling anymor
		if !Player.Grounded and SpinOffset
		{
			RawY -= Player.DefaultRadiusY - Player.SmallRadiusY;
		}
		
		// Clear offset
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
	
	// Perform shaking
	if ShakeTime > 0 and ShakeStrength != 0
	{
		ShakeTime--;
		ShakeOffset = ShakeTime == 0 ? 0 : random_range(-ShakeStrength, ShakeStrength);
	}
}