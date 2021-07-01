function PlayerPhysicsHandle()
{	
	// Surface physics
	if !isUnderwater
	{	
		// Normal physics
		if !SuperState
		{
			Acc			  = 0.046875;
			GlidingAcc    = 0.015625;
			AirAcc		  = 0.09375;
			Dec			  = 0.5;
			RollDec		  = 0.125;
			Frc			  = 0.046875;
			RollFrc		  = 0.0234375;
			TopAcc		  = 6;	
			ClimbingSpeed = 1;
			JumpMin		  = -4;
			Jump		  = CharacterID == CharKnuckles ? -6 : -6.5;
		}
		
		// Super physics
		else
		{
			// Sonic
			if CharacterID == CharSonic
			{
				Acc     = 0.1875;
				AirAcc  = 0.375;
				Dec     = 1;
				RollDec = 0.125;
				Frc     = 0.046875;
				RollFrc = 0.09375;
				TopAcc  = 10;
				JumpMin = -4;
				Jump    = -8;
			}
			
			// Tails and Knuckles
			else
			{
				Acc           = 0.09375;
				AirAcc        = 0.1875;
				GlidingAcc    = 0.015625;
				Dec           = 0.75;
				RollDec       = 0.125;
				Frc           = 0.046875;
				RollFrc       = 0.0234375;
				TopAcc		  = 8;
				ClimbingSpeed = 2;
				JumpMin		  = -4;
				Jump          = CharacterID == CharKnuckles ? -6 : -6.5;
			}
		}
		
		// High-speed shoes
		if HighSpeedBonus
		{
			Acc	    = 0.09375;
			AirAcc  = 0.1875;
			Frc		= 0.09375;
			RollFrc = 0.046875;
			TopAcc  = 12;
		}
	}
	
	// Underwater physics
	else
	{
		// Normal physics
		if !SuperState
		{
			Acc			  = 0.0234375;
			AirAcc		  = 0.046875;
			GlidingAcc    = 0.046875;
			Dec			  = 0.25;
			RollDec		  = 0.125;
			Frc			  = 0.0234375;
			RollFrc		  = 0.01171875;
			TopAcc		  = 3;	
			ClimbingSpeed = 1;
			JumpMin		  = -2;
			Jump		  = CharacterID == CharKnuckles ? -3 : -3.5;
		}
		
		// Super physics
		else
		{
			// Sonic
			if CharacterID == CharSonic
			{
				Acc     = 0.09375;
				AirAcc  = 0.1875;
				Dec     = 0.5;
				RollDec = 0.125;
				Frc     = 0.046875;
				RollFrc = 0.046875;
				TopAcc  = 5;
				JumpMin = -2;
				Jump    = -3.5;
			}
			
			// Tails and Knuckles
			else
			{
				Acc           = 0.046875;
				AirAcc        = 0.09375;
				GlidingAcc    = 0.046875;
				Dec           = 0.375;
				RollDec       = 0.125;
				Frc           = 0.046875;
				RollFrc       =	0.0234375;
				TopAcc		  = 4;
				ClimbingSpeed = 2;
				JumpMin		  = -2;
				Jump		  = CharacterID == CharKnuckles ? -3 : -3.5;
			}
		}
	}
			
	// Keep rolling friction constant
	if Game.ConstantRollFrc and SuperState
	{
		RollFrc = 0.0234375;
	}
	
	// Handle basic gravity
	if !Hurt and !Death and !FlyingState and !GlidingState and !ClimbingState
	{
		if !isUnderwater
		{
			Grv	= 0.21875;
		}
		else
		{
			Grv = 0.0625;
		}
	}
}