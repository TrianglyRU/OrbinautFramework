function PlayerStateUpdate()
{
	// Check for entering for exiting debug mode
	if Game.DevMode and Input.CPress and !Death
	{
		DebugMode      = !DebugMode;	
		DebugSpeed     = 0;
		Hurt		   = false;
		MovementLock   = false;
		SpindashRev    = -1;
		PeeloutRev     = -1;
		DropdashRev    = -1;
		Grounded	   =  DebugMode;
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