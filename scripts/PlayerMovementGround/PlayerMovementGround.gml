function PlayerMovementGround()
{	
	if !MovementLock and !NoControls
	{
		// Left key is pressed?
		if Input.Left
		{	
			// Decelerate
			if Inertia > 0 
			{
				// Decelerate
				Inertia -= Dec;
				if Inertia <= 0
				{
					Inertia = -0.5;	
				}
			} 
			
			// Accelerate
			else
			{
				if Facing != FlipLeft
				{
					Facing  = FlipLeft;
					Pushing = false;
				}
				if !Game.GroundSpeedcap and Inertia > -TopAcc or Game.GroundSpeedcap
				{
					Inertia = max(Inertia - Acc, -TopAcc);
				} 
			}
		}
		
		// Right key is pressed?
		else if Input.Right
		{			
			// Decelerate
			if Inertia < 0 
			{
				Inertia += Dec;
				if Inertia >= 0
				{
					Inertia = 0.5;
				}
			} 
			
			// Accelerate
			else
			{
				if Facing != FlipRight
				{
					Facing  = FlipRight;
					Pushing = false;
				}
				if !Game.GroundSpeedcap and Inertia < TopAcc or Game.GroundSpeedcap
				{
					Inertia = min(Inertia + Acc, TopAcc);
				} 
			}
		}
	}
	
	// Apply friction if no directional buttons held
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
		Pushing = false;
	}
	
	// Convert inertia to speeds
	Xsp = Inertia *  dcos(Angle);
	Ysp = Inertia * -dsin(Angle);
	
	// Set animation
	if Pushing
	{
		Animation = AnimPush;
	}
	else
	{
		if (Angle <= 45 or Angle >= 315) and Inertia == 0 
		{
			if !Input.Up and !Input.Down
			{
				Animation = AnimIdle;
			}
		}
		else
		{
			var RunSpeed = (SuperState and Game.Character == CharSonic) ? 8 : TopAcc;
			if abs(Inertia) < RunSpeed
			{
				Animation = AnimWalk;
			}
			else if abs(Inertia) < 10
			{
				Animation = AnimRun;
			}
			else
			{
				Animation = AnimPeelout;
			}
		}
	}
}