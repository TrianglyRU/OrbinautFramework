/// @description
// You can write your code in this editor
	
	if object_player_overlap(CollisionTriggerbox)
	{
		if !Active
		{
			Active = true;
			
			Player.FlightState = false;
			Player.GlideState  = false;
			
			// Reset gravity
			if !Player.IsUnderwater
			{
				Player.Grv = 0.21875;
			}
			else
			{
				// Lower by 0x28 (0.15625) if underwater
				Player.Grv = 0.0625
			}
			
			Player.Grounded   = true;
			Player.ForcedRoll = true;
		}
	}
	else if Active
	{
		Active			  = false;
		Player.ForcedRoll = false;
	}