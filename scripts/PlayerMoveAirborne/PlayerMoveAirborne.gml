function PlayerMoveAirborne()
{	
	// Reset flags
	Skidding  = false;
	Balancing = false;
	Pushing	  = false;
	
	// Accelerate and decelerate
	if !Game.RolljumpControl and !(Jumping and Rolling)
	or  Game.RolljumpControl
	{
		if !GlidingState and !ClimbingState and !Hurt and !Death and SuperState != 1
		{
			if Input.Left 
			{		
				if Xsp > 0 
				{
					Xsp -= AirAcc;
				} 
				else if (!Game.AirSpeedcap and Xsp > -TopAcc) or Game.AirSpeedcap
				{
					Xsp -= AirAcc;
					if (Xsp <= -TopAcc) Xsp = -TopAcc;
				}
				Facing = DirLeft;
			}
			if Input.Right 
			{	
				if Xsp < 0 
				{
					Xsp += AirAcc;
				} 
				else if (!Game.AirSpeedcap and Xsp < TopAcc) or Game.AirSpeedcap
				{
					Xsp += AirAcc;
					if (Xsp >= TopAcc) Xsp = TopAcc;
				}
				Facing = DirRight;
			}	
		}
	}
	
	// Apply air drag
	if Ysp < 0 and Ysp > -4 and !Hurt and !GlidingState
	{
		Xsp -= floor(Xsp/0.125) / 256;
	}
	
	// Handle spring animation
	if Animation = AnimSpring and Ysp > 0
	{
		Animation = AnimWalk;
	}
	
	// Transform
	if !SuperState
	{
		if Jumping and Ysp <= 0 and Rings >= 50 and !SuperStateValue and Input.ABCPress
		{
			SuperState = true;
			Jumping    = false;
		}
	}
	else if Jumping and Input.ABCPress
	{
		SuperStateValue = 0;
		SuperState		= false;
	}
	
	// Do transfomation sequence
	if SuperState == true
	{	
		// Play animation
		Animation = AnimTransform;
		
		// Switch to another animation
		if SuperStateValue == 24
		{
			Animation = AnimWalk;
		}
		
		// Reset speeds
		Inertia = 0;
		Xsp		= 0;
		Ysp		= 0;
	}
}