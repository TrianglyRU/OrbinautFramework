function ObjRollTriggerMain()
{	
	// Check for overlap
	if object_check_overlap(TypeTrigger) 
	{
		/* Force player to land if gliding or flying. We don't really call 
		scripts like that but it is needed here */
		/*if Player.GlideState or Player.FlightState
		{
			with Player
			{
				Grounded = true; PlayerResetOnFloor();
			}
		}*/
		
		// Force player to roll
		if Player.Grounded or Player.GlideState
		{
			if !State and abs(Player.Inertia) < 4
			{
				Player.Inertia = 4 * Player.Facing;
			}
			Player.ForcedRoll = true;
		
			// Increment state
			State = 1;
		}
	}
	
	// Reset
	else if State
	{
		State			  = false;
		Player.ForcedRoll = false;
	}
}