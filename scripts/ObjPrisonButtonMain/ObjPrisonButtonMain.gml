function ObjPrisonButtonMain()
{
	// Check if button hasn't been pressed
	if !State
	{	
		// Do collision
		object_act_solid(true, true, true, true);
		
		// Check if player is standing on the object
		if object_check_touch(TypeSolidU)
		{	
			y           += 8;
			image_index  = 0;
			
			// Increment state
			State++;
		}
	}
	
	// Release player
	else if object_check_touch(TypeSolidU)
	{	
		Player.Grounded = false;
		Player.OnObject = false;
	}
}