function ScreenCameraFollowProcess() 
{	
	// Do not perform if camera is disabled
	if !CameraEnabled
	{
		exit;
	}
	
	// Update player's position on the screen
	PlayerScreenX = floor(Player.PosX) - RawX;	
	PlayerScreenY = floor(Player.PosY) - RawY;
	
	// Set horizontal shift speed
	if PlayerScreenX <= Width / 2 - 16 
	{ 
		SpeedX = clamp(PlayerScreenX - (Width / 2 - 16), -16, 0);  
	}
	else if PlayerScreenX >= Width / 2
	{ 
		SpeedX = clamp(PlayerScreenX - (Width / 2), 0, 16);    
	}
	
	// Horizontal follow
	if ScrollDelay
	{
		// Decrease lag timer
		ScrollDelay--;
	}
	else if PlayerScreenX >= (Width / 2) or PlayerScreenX <= (Width / 2 - 16)
	{
		RawX += SpeedX;
	}

	// Set vertical shift speed
	if Player.Grounded or Player.GlideState == GlideStop
	{
		var maxShift = abs(Player.Ysp) < 6 ? 6 : 16;
		SpeedY      = clamp(PlayerScreenY - (Height / 2 - 16), -maxShift, maxShift);  
	} 
	else 
	{
		if PlayerScreenY <= Height / 2 - 48 
		{ 
			SpeedY = clamp(PlayerScreenY - (Height / 2 - 48), -16, 0);  
		} 
		else if PlayerScreenY >= Height / 2 + 16 
		{ 
			SpeedY = clamp(PlayerScreenY - (Height / 2 + 16), 0, 16);  
		}
	}	
	
	// Vertical follow
	if Player.Grounded or Player.GlideState == GlideStop
	{
		if PlayerScreenY != Height / 2 - 16 
		{
			RawY += SpeedY
		}
	} 
	else
	{
		if PlayerScreenY <= Height / 2 - 48 and Player.Ysp <= 0
		or PlayerScreenY >= Height / 2 + 16 and Player.Ysp >= 0 
		{
			RawY += SpeedY
		}
	}
}