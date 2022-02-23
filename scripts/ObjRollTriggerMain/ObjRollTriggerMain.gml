function ObjRollTriggerMain()
{	
	// Check for overlap
	if object_check_touch(ColTrigger) 
	{
		// Force player to roll
		if Player.Grounded or Player.GlideState
		{
			if !State and abs(Player.Gsp) < 2
			{
				Player.Gsp = 2 * Player.Facing;
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