function CameraOffsetsProcess()
{	
	// Exit if camera is disabled or target is not player
	if !Enabled or Target != Player or !instance_exists(Target)
	{
		exit;
	}
	
	// Update extended camera offset
	if Game.ExtendedCamera
	{
		var ScreenShift = Game.Width / 2 - 96;
		var ScreenSpeed = floor(ScreenShift / 32);
		
		if abs(Player.Inertia) >= 6 or Player.PeeloutRev >= 16 or Player.SpindashRev >= 0
		{
			if !ScrollDelay and abs(ExtendedOffset) < ScreenShift
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
	if Player.Spinning and Player.Grounded
	{
		SpinOffset = Player.DefaultRadiusY - Player.SmallRadiusY;
	} 
	else 
	{
		// Reset it
		if !Player.Grounded and SpinOffset
		{
			//PosY -= Player.DefaultRadiusY - Player.SmallRadiusY;
		}
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
			if OverviewDelay
			{
				OverviewDelay--;
			}
		} 
		else if !OverviewOffset
		{
			OverviewDelay = 120;
		}
	} 
	else 
	{
		OverviewDelay = 0;
	}
	
	// Shift up/down
	if !OverviewDelay
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