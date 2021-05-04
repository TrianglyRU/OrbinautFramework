function ScreenCameraFollowPlayer() 
{	
	// Do not perform if camers is disabled
	if (!CameraEnabled) exit;
	
	// Update player's position on the screen
	PlayerScreenX = floor(Player.PosX) - floor(RawX);
	PlayerScreenY = floor(Player.PosY) - floor(RawY);
	
	// Set horizontal shift speed
	if PlayerScreenX <= Width / 2 - 16 
	{ 
		ScrollX = clamp(PlayerScreenX - (Width / 2 - 16), -16, 0);  
	}
	else if PlayerScreenX >= Width / 2
	{ 
		ScrollX = clamp(PlayerScreenX - (Width / 2), 0, 16);    
	}
	
	// Horizontal follow
	if (PlayerScreenX >= (Width / 2) or PlayerScreenX <= (Width / 2 - 16)) and ScrollDelay == 0 
	{ 
		RawX += ScrollX;
	}

	// Set vertical shift speed
	if Player.Grounded and !Player.GlidingState or Player.GlidingState == 4
	{
		var maxShift = abs(Player.Ysp) < 6 ? 6 : 16;
		ScrollY      = clamp(PlayerScreenY - (Height / 2 - 16), -maxShift, maxShift);  
	} 
	else 
	{
		if PlayerScreenY <= Height / 2 - 48 
		{ 
			ScrollY = clamp(PlayerScreenY - (Height / 2 - 48), -16, 0);  
		} 
		else if PlayerScreenY >= Height / 2 + 16 
		{ 
			ScrollY = clamp(PlayerScreenY - (Height / 2 + 16), 0, 16);  
		}
	}	
	
	// Vertical follow
	if Player.Grounded
	{
		if PlayerScreenY != Height / 2 - 16 
		{
			RawY += ScrollY
		}
	} 
	else 
	{
		if PlayerScreenY < Height / 2 - 48 and Player.Ysp < 0
		or PlayerScreenY > Height / 2 + 16 and Player.Ysp > 0 
		{
			RawY += ScrollY
		}
	}
}