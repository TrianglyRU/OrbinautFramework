function ObjCollisionTriggerMain()
{
	// Check for GroundOnly flag
	if GroundOnly and !Player.Grounded
	{
		exit;
	}
	
	// Change layer if we passed through the object
	if !object_check_overlap(TypeTrigger)
	{
		if State
		{
			if floor(Player.PosX) > x and RightDirection != "None"
			{
				Player.Layer = RightDirection;
			}
			else if floor(Player.PosX) <= x and LeftDirection != "None"
			{
				Player.Layer = LeftDirection;
			}
			State = 0;
		}
	}
	
	// Increment state on overlap
	else
	{
		State = min(State + 1, 1);
	}	
}