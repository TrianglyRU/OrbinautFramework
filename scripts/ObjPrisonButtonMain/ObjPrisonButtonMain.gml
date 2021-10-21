function ObjPrisonButtonMain()
{
	// Check if button hasn't been pressed
	if !State
	{	
		// Do collision
		object_act_solid(true, true, true, true);
		
		// Check if player is standing on the object
		if object_check_touch(SideTop)
		{
			Player.PosY += 8;	
			y           += 8;
			image_index  = 0;
			
			// Increment state
			State++;
		}
	}
	
	// Disable collisions
	else if Player.OnObject == id
	{	
		Player.Grounded = false;
		Player.OnObject = false;
	}
}