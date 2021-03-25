function PlayerMove()
{	
	// Accelerate and decelerate
	if MovementLock = false
	{
		if Input.Left
		{	
			// If moving right and left key is pressed, decelerate
			if Inertia > 0 
			{
				Inertia -= Dec;
				if (Inertia <= 0) Inertia = -0.5;	
			} 
			
			// If moving left and left key is pressed, accelerate
			else
			{
				if (!Game.GroundSpeedcap and Inertia > -TopAcc) or Game.GroundSpeedcap
				{
					Inertia -= Acc;					
					if (Inertia <= -TopAcc) Inertia = -TopAcc;		
				} 
				Facing = FacingLeft;
			}
		}
		if Input.Right 
		{				
			// If moving left and right key is pressed, decelerate
			if Inertia < 0 
			{
				Inertia += Dec;
				if (Inertia >= 0) Inertia = 0.5;
			} 
			
			// If moving right and right key is pressed, accelerate
			else
			{
				if (!Game.GroundSpeedcap and Inertia < TopAcc) or Game.GroundSpeedcap
				{
					Inertia += Acc;
					if (Inertia >= TopAcc) Inertia = TopAcc;
				} 
				Facing = FacingRight;
			}
		}
	}
	
	// Apply friction
	if !Input.Left and !Input.Right and Inertia != 0 or MovementLock != 0
	{
		if Inertia > 0
		{
			Inertia -= Acc;
			if (Inertia < 0) Inertia = 0;
		}
		else
		{
			Inertia += Acc;
			if (Inertia >= 0) Inertia = 0;
		}
	}
	
	// Set animation
	Animation = Inertia == 0 ? AnimIdle : (abs(Inertia) < TopAcc ? AnimWalk : AnimRun);

	// Get our speed ratio
	AnimReservedSpeed = round(max(1, 8 - abs(Inertia)));

	// Convert inertia to normal axis speeds
	Xsp = Inertia *  dcos(Angle);
	Ysp = Inertia * -dsin(Angle);
}