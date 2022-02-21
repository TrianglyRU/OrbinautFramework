function ObjRollTriggerMain()
{	
	if object_check_touch(ColTrigger) 
	{
		if !State
		{
			if !Player.ForcedRoll
			{
				// Force player to roll
				if Player.Grounded or Player.GlideState
				{
					if abs(Player.Gsp) < 2
					{
						Player.Gsp = 2 * Player.Facing;
					}
				}
				Player.ForcedRoll = true;
				
				State = 1;
			}
			
			// If already forced to roll, tell the object to clear our flag once we cross it
			else
			{
				State = 2;
			}	
		}
	}
	else if State
	{
		if State == 2
		{
			Player.ForcedRoll = false;
		}
		State = 0;
	}
}