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
		if !Active
		{
			Player.Inertia = 4 * abs(Player.Facing);
		}
		Active = true;
	}
	
	// Reset
	else if Active
	{
		Active			  = false;
		Player.ForcedRoll = false;
	}
}