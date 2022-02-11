function ObjCollisionTriggerMain()
{
	// Check for GroundOnly flag
	if !State and GroundOnly and !Player.Grounded
	{
		return;
	}
	
	// Update active collision layer if player passed through the object
	if !object_check_touch(ColTrigger)
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
			else if floor(Player.PosY) > y and DownDirection != "None"
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
}