function PlayerGeneralUpdate()
{
	// Update main state
	if Grounded
	{
		State = !Rolling ? PlayerStateNormal : PlayerStateRoll;
	}
	else
	{
		State = PlayerStateAirborne;
	}
	
	// Handle highspeed bonus
	if HighSpeedBonus > 0
	{	
		// Decrease timer
		HighSpeedBonus--;
		
		// Apply increased values
		Acc     = 0.09375;
		Frc     = 0.09375;
		AirAcc  = 0.1875;
		RollFrc = 0.046875;
		TopAcc  = 12;
		
		// Back to default values when bonus has ended or we became super
		if HighSpeedBonus = 0 or isSuper
		{
			Acc	    = 0.046875;
			Frc     = 0.046875;
			AirAcc  = Acc * 2;
			RollFrc = Frc / 2;
			TopAcc  = 6;
		}
	}
	
	// Handle super state
	if isSuper
	{
		// Make us invincible
		isInvincible = true;
		
		if Rings > 0
		{
			// Apply increased values
			if (CharacterID  = CharSonic)
			{
				Acc	    = 0.1875;
				AirAcc  = 0.375;
				Dec     = 1;
				TopAcc  = 10;
				Jump    = 8;
				RollFrc = Game.ConstantRollFrc ? 0.0234375 : 0.09375;
			}
			else
			{
				Acc     = 0.09375;
				AirAcc  = 0.1875;
				Dec     = 0.75;
				TopAcc  = 8;		
				RollFrc = 0.0234375;
				Jump    = 8;
			}
			Frc = 0.046875;
			
			// Decrease rings
			Rings -= 1/60;
		}
		
		// Leave super state if no rings left
		else
		{
			isSuper = false;
			Acc		= 0.046875;
			Frc     = 0.046875;
			AirAcc  = Acc * 2;
			RollFrc = Frc / 2;
			Dec		= 0.5;
			Jump	= 6.5;
			TopAcc	= 6;
		}
	}
	
	// Handle invincibility bonus
	if (InvincibilityBonus > 0) InvincibilityBonus--;
	
	// Decrease temp invincibility timer
	if (isInvincible and !InvincibilityBonus and !isSuper) isInvincible--;
}