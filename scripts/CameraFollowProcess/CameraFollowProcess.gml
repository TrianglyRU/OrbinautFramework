function CameraFollowProcess() 
{	
	// Exit if camera is disabled or no target set
	if !Enabled or !instance_exists(Target)
	{
		exit;
	}
	
	// Get target's position relative to camera
	if Target == Player
	{
		TargetX = floor(Player.PosX) - PosX;
		TargetY = floor(Player.PosY) - PosY;
	}
	else
	{
		TargetX = Target.x - PosX;
		TargetY = Target.y - PosY;
	}
	
	// Set horizontal shift speed
	if TargetX <= Game.Width / 2 - 16 
	{ 
		ShiftX = clamp(TargetX - (Game.Width / 2 - 16), -MaxShiftX, 0);  
	}
	else if TargetX >= Game.Width / 2
	{ 
		ShiftX = clamp(TargetX - (Game.Width / 2), 0, MaxShiftX);    
	}
	else
	{
		ShiftX = 0;
	}
	
	// Set vertical shift speed
	if Target == Player and Player.Grounded
	{	
		if abs(Player.Ysp) <= 6
		{
			MaxShiftY = 6;
		}
		if abs(Player.Inertia) >= 8
		{
			MaxShiftY = 16;
		}
		ShiftY = clamp(TargetY - (Game.Height / 2 - 16), -MaxShiftY, MaxShiftY);
	} 
	else 
	{
		MaxShiftY = 16;
		
		if TargetY <= Game.Height / 2 - 48 
		{ 
			ShiftY = clamp(TargetY - (Game.Height / 2 - 48), -MaxShiftY, 0);  
		} 
		else if TargetY >= Game.Height / 2 + 16 
		{ 
			ShiftY = clamp(TargetY - (Game.Height / 2 + 16), 0, MaxShiftY);  
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