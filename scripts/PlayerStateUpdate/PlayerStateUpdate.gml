function PlayerStateUpdate()
{
	// Check for entering for exiting debug mode
	if Game.DevMode and Input.CPress
	{
		DebugMode      = !DebugMode;	
		DebugSpeed     = 0;
		Hurt		   = false;
		Death		   = false;
		Grounded	   = DebugMode;
		AllowCollision = !DebugMode;	
	}
	
	// Update player's state
	if !DebugMode
	{
		if Grounded
		{
			State = !Rolling ? PlayerStateNormal : PlayerStateRoll;
		}
		else
		{
			State = PlayerStateAirborne;
		}
	}
	else
	{
		State = PlayerStateDebug;
	}
}