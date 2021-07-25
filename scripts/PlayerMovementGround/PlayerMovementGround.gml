function PlayerMovementGround()
{	
	if SpindashRev >= 0 or PeeloutRev >= 0
	{
		exit;
	}
	
	if !MovementLock
	{
		if Input.Left
		{	
			if Inertia > 0 
			{
				Inertia -= Dec;
				if Inertia <= 0
				{
					Inertia = -0.5;	
				}
			} 
			else
			{
				if !Game.GroundSpeedcap and Inertia > -TopAcc or Game.GroundSpeedcap
				{
					Inertia = max(Inertia - Acc, -TopAcc);
				} 
				Facing = DirectionLeft;
			}
		}
		else if Input.Right
		{				
			if Inertia < 0 
			{
				Inertia += Dec;
				if Inertia >= 0
				{
					Inertia = 0.5;
				}
			} 
			else
			{
				if !Game.GroundSpeedcap and Inertia < TopAcc or Game.GroundSpeedcap
				{
					Inertia = min(Inertia + Acc, TopAcc);
				} 
				Facing = DirectionRight;
			}
		}
	}
	
	if (!Input.Left and !Input.Right) or MovementLock
	{
		if Inertia > 0
		{
			Inertia = max(Inertia - Frc, 0);
		}
		else
		{
			Inertia = min(Inertia + Frc, 0);
		}
	}

	Xsp = Inertia *  dcos(Angle);
	Ysp = Inertia * -dsin(Angle);
	
	// Check if we're moving
	if Inertia != 0
	{
		// Check for walk
		if abs(Inertia) < 6
		{
			Animation = AnimWalk;
		}
		
		// Check for run
		else if abs(Inertia) < 10
		{
			Animation = AnimRun;
		}
		
		// Check for very fast run
		else
		{
			if CharacterID == CharSonic and Game.PeeloutEnabled 
			or CharacterID == CharTails
			{
				Animation = AnimPeelout;
			}
		}
	}
	else if !Input.Down and !Input.Up and SlopeGravity == 0
	{
		Animation = AnimIdle;
	}
}