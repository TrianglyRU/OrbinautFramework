function PlayerMovementGround()
{	
	if !MovementLock and !NoControls
	{
		// Left key is pressed?
		if Input.Left
		{	
			// Are we moving to the right?
			if Inertia > 0 
			{
				// Decelerate
				Inertia -= Dec;
				if Inertia <= 0
				{
					Inertia = -0.5;	
				}
			} 
			
			// Are we moving to the left?
			else
			{
				// Accelerate
				if !Game.GroundSpeedcap and Inertia > -TopAcc or Game.GroundSpeedcap
				{
					Inertia = max(Inertia - Acc, -TopAcc);
				} 
				Facing = DirectionLeft;
			}
		}
		
		// Right key is pressed?
		else if Input.Right
		{			
			// Are we moving to the left?
			if Inertia < 0 
			{
				// Decelerate
				Inertia += Dec;
				if Inertia >= 0
				{
					Inertia = 0.5;
				}
			} 
			
			// Are we moving to the right?
			else
			{
				// Accelerate
				if !Game.GroundSpeedcap and Inertia < TopAcc or Game.GroundSpeedcap
				{
					Inertia = min(Inertia + Acc, TopAcc);
				} 
				Facing = DirectionRight;
			}
		}
	}
	
	// Apply friction
	if (!Input.Left and !Input.Right) or MovementLock or NoControls
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
	
	// Convert inertia to speeds
	Xsp = Inertia *  dcos(Angle);
	Ysp = Inertia * -dsin(Angle);
	
	// Use 'idle' anmation
	if (Angle <= 45 or Angle >= 316.41) and Inertia == 0 
	{
		if !Input.Up and !Input.Down
		{
			Animation = AnimIdle;
		}
	}
	else
	{
		// Set 'walk' or 'run' animaton
		var WalkLimit = SuperState ? 8 : 6;
		Animation = abs(Inertia) < WalkLimit ? AnimWalk : AnimRun;
			
		// Use 'peelout' animation is running very fast as Sonic
		if CharacterID == CharSonic and Game.PeeloutEnabled and abs(Inertia) >= 10
		{
			Animation = AnimPeelout;
		}
	}
}