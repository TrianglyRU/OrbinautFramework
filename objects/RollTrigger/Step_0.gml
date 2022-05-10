/// @description Main
// You can write your code in this editor
	
	if object_check_player(ColTrigger) 
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