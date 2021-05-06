function AIGeneralUpdate()
{
	// Update player's state
	if Grounded
	{
		State = !Rolling ? PlayerStateNormal : PlayerStateRoll;
	}
	else
	{
		State = PlayerStateAirborne;
	}
	
	// Handle underwater physics
	if !isUnderwater
	{
		// Check for falling into the water
		if PosY > Stage.WaterLevel and Stage.WaterLevel != 0
		{
			Xsp	*= 0.5;
			Ysp	*= 0.25;
			isUnderwater = true;
		}
	}
	else
	{ 
		// Apply underwater physics
		Acc		= 0.0234375;
		Dec		= 0.25;
		Frc		= 0.0234375;
		RollFrc = 0.01171875;
		TopAcc  = 3;
		AirAcc  = 0.046875;
		JumpMin = -2;
		Jump    = 3.5;
		Grv	    = 0.0625;
		
		// Check for leaving the water
		if PosY < Stage.WaterLevel
		{
			isUnderwater = false;
			Ysp			*= 2;
			
			// Restore normal physics
			Acc		= 0.046875;
			Frc     = 0.046875;
			AirAcc  = 0.09375;
			RollFrc = 0.0234375;
			Dec		= 0.5;			
			TopAcc	= 6;
			JumpMin = -4;
			Jump    = 6.5;
			Grv		= 0.21875;
		}
	}
	
	// Decrease temp invincibility timer
	if (isInvincible) isInvincible--;
}