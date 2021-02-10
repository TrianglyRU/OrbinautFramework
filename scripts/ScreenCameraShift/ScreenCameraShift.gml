function ScreenCameraShift() 
{		
	// Update player's position on the screen
	//PlayerScreenX = Player.PosX - RenderX;
	//PlayerScreenY = Player.PosY - RenderY;	
	PlayerScreenX = Player.RealPosX - ViewX;
	PlayerScreenY = Player.RealPosY - ViewY;
	
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
		ShiftY       = clamp(PlayerScreenY - (Height / 2 - 16), -maxShift, maxShift);  
	} 
	else 
	{
		if PlayerScreenY <= Height / 2 - 48 
		{ 
			ShiftY = clamp(PlayerScreenY - (Height / 2 - 48), -16, 0);  
		} 
		else if PlayerScreenY >= Height / 2 + 16 
		{ 
			ShiftY = clamp(PlayerScreenY - (Height / 2 + 16), 0, 16);  
		}
	}	
	
	// Vertical follow
	if Player.Grounded
	{
		if PlayerScreenY != Height / 2 - 16 
		{
			ViewY += ShiftY
		}
	} 
	else 
	{
		if PlayerScreenY < Height / 2 - 48 and Player.Ysp < 0
		or PlayerScreenY > Height / 2 + 16 and Player.Ysp > 0 
		{
			ViewY += ShiftY
		}
	}
}