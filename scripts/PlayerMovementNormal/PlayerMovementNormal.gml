function PlayerMovementNormal()
{	
	// Exit if spindashing
	if SpindashRev >= 0 exit;
	
	// Accelerate and decelerate
	if !MovementLock
	{
		if Input.Left 
		{	
			// If moving right and left key is pressed, decelerate
			if Inertia > 0 
			{
				Inertia -= Dec;
				if Inertia <= 0
				{
					Inertia = -0.5;	
				}
			} 
			
			// If moving left and left key is pressed, accelerate
			else 
			{
				Facing = FacingLeft;

				if !Game.GroundSpeedcap 
				{
					if Inertia > -TopAcc 
					{
						Inertia -= Acc;
						if Inertia <= -TopAcc 
						{
							Inertia = -TopAcc;
						}
					}
				} 
				else 
				{
					Inertia -= Acc;
					if Inertia <= -TopAcc
					{
						Inertia = -TopAcc;
					}
				}	
			}
		}
		if Input.Right 
		{	
			// If moving left and right key is pressed, decelerate
			if Inertia < 0 
			{
				Inertia += Dec;
				if Inertia >= 0
				{
					Inertia = 0.5;
				}
			} 
			
			// If moving right and right key is pressed, accelerate
			else 
			{
				Facing = FacingRight;
				
				if !Game.GroundSpeedcap
				{
					if Inertia < TopAcc 
					{
						Inertia += Acc;
						if Inertia >= TopAcc
						{
							Inertia = TopAcc;
						}
					}
				} 
				else 
				{
					Inertia += Acc;
					if Inertia >= TopAcc
					{
						Inertia = TopAcc;
					}
				}				
			}
		}
	}
	
	// Apply friction
	if !Input.Left and !Input.Right and Inertia != 0 or MovementLock != 0
	{
		if Inertia > 0
		{
			Inertia -= Acc;
			if Inertia < 0
			{
				Inertia = 0;
			}
		}
		else
		{
			Inertia += Acc;
			if Inertia >= 0
			{
				Inertia = 0;
			}
		}
	}	
	
	// Update axis speeds
	Xsp = Inertia * dcos(Angle);
	Ysp = Inertia *-dsin(Angle);
}