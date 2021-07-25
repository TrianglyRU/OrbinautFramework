function PlayerMovementAir()
{	
	// Reset flags
	Skidding  = false;
	Balancing = false;
	Pushing	  = false;
	
	// Exit if gliding (ignoring GlideDrop state) or climbing
	if GlideState == GlideActive or GlideState == GlideStop or ClimbState
	{
		exit;
	}
	
	// Exit if hurt or dead
	if Hurt or Death or Drown
	{
		exit;
	}
	
	// Accelerate and decelerate
	if !(!Game.RolljumpControl and Jumping and Rolling)
	{
		if Input.Left 
		{		
			if Xsp > 0 
			{
				Xsp -= AirAcc;
			} 
			else if !Game.AirSpeedcap and Xsp > -TopAcc or Game.AirSpeedcap
			{
				Xsp -= AirAcc;
				if Xsp <= -TopAcc
				{
					Xsp = -TopAcc;
				}
			}
			Facing = DirectionLeft;
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
				if Xsp >= TopAcc
				{
					Xsp = TopAcc;
				}
			}
			Facing = DirectionRight;
		}	
	}
	
	// Apply air drag
	if Ysp < 0 and Ysp > -4
	{
		Xsp -= floor(Xsp/0.125) / 256;
	}
	
	// Handle spring animation
	if Animation = AnimSpring and Ysp > 0
	{
		Animation = AnimWalk;
	}
}