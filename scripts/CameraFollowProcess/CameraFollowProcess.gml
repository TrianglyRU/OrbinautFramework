function CameraFollowProcess() 
{	
	// Exit if camera is disabled or no target set
	if !Enabled or !Target
	{
		exit;
	}
	
	// Get target's position relative to camera
	TargetX = Target.x - PosX;
	TargetY = Target.y - PosY;
	
	// Set horizontal shift speed
	if TargetX <= Game.Width / 2 - 16 
	{ 
		ShiftX = clamp(TargetX - (Game.Width / 2 - 16), -16, 0);  
	}
	else if TargetX >= Game.Width / 2
	{ 
		ShiftX = clamp(TargetX - (Game.Width / 2), 0, 16);    
	}
	else
	{
		ShiftX = 0;
	}
	
	// Set vertical shift speed
	if Target == Player and (Player.Grounded or Player.GlideState == GlideStop)
	{
		if abs(Player.Ysp) <= 6
		{
			var MaxShift = 6;
		}
		else if abs(Player.Ysp) >= 8
		{
			var MaxShift = 16;
		}
		ShiftY = clamp(TargetY - (Game.Height / 2 - 16), -MaxShift, MaxShift);  
	} 
	else 
	{
		if TargetY <= Game.Height / 2 - 48 
		{ 
			ShiftY = clamp(TargetY - (Game.Height / 2 - 48), -16, 0);  
		} 
		else if TargetY >= Game.Height / 2 + 16 
		{ 
			ShiftY = clamp(TargetY - (Game.Height / 2 + 16), 0, 16);  
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
		PosY += ShiftY;
	}
}