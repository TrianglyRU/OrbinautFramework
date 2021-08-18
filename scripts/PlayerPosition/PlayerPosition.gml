function PlayerPosition() 
{	
	// Update position
	Player.PosX += Xsp;
	Player.PosY += Ysp;	
	
	// Apply gravity when airborne
	if !Player.Grounded
	{
		Player.Ysp += Grv;
	}

	// Limit vertical speed
	if Game.LimitVerticalSpeed
	{
		if Player.Ysp > 15.75
		{
			Player.Ysp = 15.75;
		}
	}
	if Player.Ysp < -15.75
	{
		Player.Ysp = -15.75;
	}
}