function ScreenCameraShiftToPlayer() 
{	
	// Update player's position on the screen
	PlayerScreenX = Player.PosX - Screen.ViewX;
	PlayerScreenY = Player.PosY - Screen.ViewY;	
	
	// Set horizontal shift speed
	if PlayerScreenX <= Width / 2 - 16 
	{ 
		ShiftX = clamp(PlayerScreenX - (Width / 2 - 16), -16, 0);  
	}
	if PlayerScreenX >= Width / 2 
	{ 
		ShiftX = clamp(PlayerScreenX - (Width / 2), 0, 16);    
	}
	
	// Horizontal follow
	if (PlayerScreenX >= (Width / 2) or PlayerScreenX <= (Width / 2 - 16)) and ScrollDelay = 0 
	{ 
		ViewX += ShiftX;
	}

	// Set vertical shift speed
	if Player.Grounded or Player.OnObject 
	{
		var maxShift = abs(Player.Ysp) < 6 ? 6 : 16;
		ShiftY       = clamp(PlayerScreenY - 96, -maxShift, maxShift);  
	} 
	else 
	{
		if PlayerScreenY <= 64 
		{ 
			ShiftY = clamp(PlayerScreenY - 64, -16, 0);  
		} 
		else if PlayerScreenY >= 128 
		{ 
			ShiftY = clamp(PlayerScreenY - 128, 0, 16);  
		}
	}	
	
	// Vertical follow
	if Player.Grounded or Player.OnObject 
	{
		if PlayerScreenY != 96 
		{
			ViewY += ShiftY
		}
	} 
	else 
	{
		if PlayerScreenY < 64  and Player.Ysp < 0
		or PlayerScreenY > 128 and Player.Ysp > 0 
		{
			ViewY += ShiftY
		}
	}
}