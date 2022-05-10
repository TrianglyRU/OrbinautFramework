function PlayerPhysicsHandle()
{	
	// Surface physics
	if !IsUnderwater
	{	
		// Normal physics
		if !SuperState
		{
			Acc			  = 0.046875;
			GlideAcc      = 0.015625;
			AirAcc		  = 0.09375;
			Dec			  = 0.5;
			RollDec		  = 0.125;
			Frc			  = 0.046875;
			RollFrc		  = 0.0234375;
			TopAcc		  = 6;	
			ClimbSpeed    = 1;
			JumpMin		  = -4;
			Jump		  = global.Character == CharKnuckles ? -6 : -6.5;
		}
		
		// Super physics
		else
		{
			// Sonic
			if global.Character == CharSonic
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
				GlideAcc      = 0.046875;
				Dec           = 0.75;
				RollDec       = 0.125;
				Frc           = 0.046875;
				RollFrc       = 0.0234375;
				TopAcc		  = 8;
				ClimbSpeed    = 2;
				JumpMin		  = -4;
				Jump          = global.Character == CharKnuckles ? -6 : -6.5;
			}
		}
		
		// High-speed bonus physics
		if HighspeedBonus
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
			GlideAcc      = 0.015625;
			Dec			  = 0.25;
			RollDec		  = 0.125;
			Frc			  = 0.0234375;
			RollFrc		  = 0.01171875;
			TopAcc		  = 3;	
			ClimbSpeed    = 1;
			JumpMin		  = -2;
			Jump		  = global.Character == CharKnuckles ? -3 : -3.5;
		}
		
		// Super physics
		else
		{
			// Sonic
			if global.Character == CharSonic
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
				GlideAcc      = 0.046875;
				Dec           = 0.375;
				RollDec       = 0.125;
				Frc           = 0.046875;
				RollFrc       =	0.0234375;
				TopAcc		  = 4;
				ClimbSpeed    = 2;
				JumpMin		  = -2;
				Jump		  = global.Character == CharKnuckles ? -3 : -3.5;
			}
		}
	}
	
	// Overwrite RollDec for Tails
	if !global.SKRollDeceleration
	{
		if global.Character == CharTails
		{
			RollDec = Dec / 4;
		}
	}
	
	// Overwrite rolling friction constant when super
	else if SuperState
	{
		RollFrc = 0.0234375;
	}
}