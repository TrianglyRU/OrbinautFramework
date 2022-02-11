function ObjRollTriggerMain()
{	
	if object_check_touch(ColTrigger) 
	{
		// Force player to roll
		if Player.Grounded or Player.GlideState
		{
			if !State and abs(Player.Gsp) < 4
			{
				Player.Gsp = 4 * Player.Facing;
			}
			Player.ForcedRoll = true;
		
			// Increment state
			State++;
		}
	}
	else if State
	{
		State			  = false;
		Player.ForcedRoll = false;
	}
}