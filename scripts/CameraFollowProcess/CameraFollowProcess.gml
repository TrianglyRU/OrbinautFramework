function CameraFollowProcess() 
{	
	if !Enabled or !instance_exists(Target)
	{
		return;
	}
	
	// Get target's position relative to camera
	if Target == Player
	{
		if Player.Spinning and Player.ClimbState != ClimbJump
		{
			var Offset = (Player.DefaultRadiusY - Player.RadiusY);
		}
		else
		{
			var Offset = 0;
		}
		TargetX = floor(Player.PosX) - PosX;
		TargetY = floor(Player.PosY) - PosY - Offset;
	}
	else
	{
		TargetX = Target.x - PosX;
		TargetY = Target.y - PosY;
	}
	
	// Set horizontal shift speed
	if TargetX <= global.Width / 2 - 16 
	{ 
		ShiftX = clamp(TargetX - (global.Width / 2 - 16), -MaxShiftX, 0);  
	}
	else if TargetX >= global.Width / 2
	{ 
		ShiftX = clamp(TargetX - (global.Width / 2), 0, MaxShiftX);    
	}
	else
	{
		ShiftX = 0;
	}
	
	// Set vertical shift speed
	if Target == Player and Player.Grounded
	{	
		if abs(Player.Gsp) >= 8
		{
			var Limit = MaxShiftY;
		}
		else
		{
			var Limit = 6;
		}
		ShiftY = clamp(TargetY - (global.Height / 2 - 16), -Limit, Limit);
	} 
	else 
	{
		if TargetY <= global.Height / 2 - 48 
		{ 
			ShiftY = clamp(TargetY - (global.Height / 2 - 48), -MaxShiftY, 0);  
		} 
		else if TargetY >= global.Height / 2 + 16 
		{ 
			ShiftY = clamp(TargetY - (global.Height / 2 + 16), 0, MaxShiftY);  
		}
		else
		{
			ShiftY = 0;
		}
	}
	
	// Follow target
	if ScrollDelay
	{
		ScrollDelay--;
	}
	else
	{
		PosX += ShiftX;		
	}
	PosY += ShiftY;
}