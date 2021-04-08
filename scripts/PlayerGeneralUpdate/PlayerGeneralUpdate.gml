function PlayerGeneralUpdate()
{
	// Update player's state
	if Grounded
	{
		State = !Rolling ? PlayerStateNormal : PlayerStateRoll;
		switch AngleRange
		{
			case RangeFloor:
			{
				if tile_meeting(floor(PosX - xRadius * 2), floor(PosY + yRadius / 2), Layer)
				or tile_meeting(floor(PosX + xRadius * 2), floor(PosY + yRadius / 2), Layer)
				{
					AngleRange = round(Angle/90) % 4;
				}
			}
			break;
			case RangeRWall:
			{
				if tile_meeting(floor(PosX + yRadius / 2), floor(PosY - xRadius * 2), Layer)
				or tile_meeting(floor(PosX + yRadius / 2), floor(PosY + xRadius * 2), Layer)
				{
					AngleRange = round(Angle/90) % 4;
				}
			}
			break;
			case RangeRoof:
			{
				if tile_meeting(floor(PosX - xRadius * 2), floor(PosY - yRadius / 2), Layer)
				or tile_meeting(floor(PosX + xRadius * 2), floor(PosY - yRadius / 2), Layer)
				{
					AngleRange = round(Angle/90) % 4;
				}
			}
			break;
			case RangeLWall:
			{
				if tile_meeting(floor(PosX - yRadius / 2), floor(PosY - xRadius * 2), Layer)
				or tile_meeting(floor(PosX - yRadius / 2), floor(PosY + xRadius * 2), Layer)
				{
					AngleRange = round(Angle/90) % 4;
				}
			}
		}
	}
	else
	{
		AngleRange = RangeFloor;
		State      = PlayerStateAirborne;
	}

	// Handle highspeed bonus
	if HighSpeedBonus > 0
	{	
		// Decrease timer
		HighSpeedBonus--;
		
		// Apply highspeed physics
		Acc     = 0.09375;
		Frc     = 0.09375;
		AirAcc  = 0.1875;
		RollFrc = 0.046875;
		TopAcc  = 12;
		
		// Restore normal physics when bonus has ended 
		if HighSpeedBonus == 0
		{
			Acc	    = 0.046875;
			Frc     = 0.046875;
			AirAcc  = 0.09375;
			RollFrc = 0.0234375;
			TopAcc  = 6;
		}
	}
	
	// Handle underwater physics
	if isUnderwater == false
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
		// Apply underwater physics (if not in superform)
		if !isSuper
		{
			Acc		= 0.0234375;
			Dec		= 0.25;
			Frc		= 0.0234375;
			RollFrc = 0.01171875;
			TopAcc  = 3;
			AirAcc  = 0.046875;
			JumpMin = -2;
			Jump    = CharacterID == CharKnuckles ? 3 : 3.5;
		}
		Grv	= 0.0625;
		
		// Check for leaving the water
		if PosY < Stage.WaterLevel
		{
			isUnderwater = false;
			Ysp			*= 2;
			
			// Restore normal physics (if not in superform)
			if !isSuper
			{
				Acc		= 0.046875;
				Frc     = 0.046875;
				AirAcc  = 0.09375;
				RollFrc = 0.0234375;
				Dec		= 0.5;			
				TopAcc	= 6;
				JumpMin = -4;
				Jump    = CharacterID == CharKnuckles ? 6 : 6.5;
			}
			Grv	= 0.21875;
		}
	}
	
	// Handle superform physics
	if isSuper
	{
		// Make us invincible
		isInvincible = true;
		
		if Rings > 0
		{
			// Apply superform physics for Sonic
			if CharacterID == CharSonic
			{
				if !isUnderwater
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
					Acc	    = 0.09375;
					AirAcc  = 0.1875;
					Dec     = 0.5;
					TopAcc  = 5;
					Jump    = 8;
					RollFrc = Game.ConstantRollFrc ? 0.0234375 : 0.046875;
				}
			}
			
			// Apply superform physics for Tails and Knuckles
			else
			{
				if !isUnderwater
				{
					Acc     = 0.09375;
					AirAcc  = 0.1875;
					Dec     = 0.75;
					TopAcc  = 8;		
					RollFrc = 0.0234375;
				}
				else
				{
					Acc     = 0.046875;
					AirAcc  = 0.1875;
					Dec     = 0.375;
					TopAcc  = 4;		
					RollFrc = 0.0234375;
				}
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
			AirAcc  = 0.09375;
			RollFrc = 0.0234375;
			Dec		= 0.5;			
			TopAcc	= 6;
			Jump    = CharacterID == CharKnuckles ? 6 : 6.5;
		}
	}
	
	// Handle invincibility bonus
	if (InvincibilityBonus > 0) InvincibilityBonus--;
	
	// Decrease temp invincibility timer
	if (isInvincible and !InvincibilityBonus and !isSuper) isInvincible--;
}