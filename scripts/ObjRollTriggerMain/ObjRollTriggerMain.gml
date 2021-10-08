function ObjRollTriggerMain()
{	
	// Check for overlap
	if object_check_overlap(Triggerbox)
	{
		// Set player flags
		Player.ForcedRoll  = true;
		Player.FlightState = false;
		Player.GlideState  = false;
		
		// Set object flag
		if !State and abs(Player.Inertia) < 4
		{
			Player.Inertia = 2 * Player.Facing;
		}
		
		// Increment state
		State = 1;
	}
	
	// Reset
	else if State
	{
		State			  = false;
		Player.ForcedRoll = false;
	}
}