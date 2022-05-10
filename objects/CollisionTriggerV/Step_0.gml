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
			if floor(Player.PosX) > x and RightDirection != "None"
			{
				Player.Layer = RightDirection;
			}
			else if floor(Player.PosX) < x and LeftDirection != "None"
			{
				Player.Layer = LeftDirection;
			}
			State = 0;
		}
	}
	
	// Increment state
	else
	{
		State = min(State + 1, 1);
	}