/// @description Main
// You can write your code in this editor

	if Player.DebugMode
	{
		return;
	}
	if GroundOnly and !Player.Grounded and !State
	{
		return;
	}
	
	// Update active collision layer if player passed through the object
	if !object_check_player(ColTrigger)
	{
		if State
		{
			if floor(Player.PosY) > y and DownDirection != "None"
			{
				Player.Layer = DownDirection;
			}
			else if floor(Player.PosY) < y and UpDirection != "None"
			{
				Player.Layer = UpDirection;
			}
			State = 0;
		}
	}
	
	// Increment state
	else
	{
		State = min(State + 1, 1);
	}	