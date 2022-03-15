/// @description Main
// You can write your code in this editor
	
	if !State
	{	
		// Do collision
		object_act_solid(true, true, false, true);
		
		if object_check_touch(ColSolidU)
		{	
			y           += 8;
			image_index  = 0;
			
			// Increment state
			State++;
		}
	}
	
	// Player should be airborne now
	else if object_check_touch(ColSolidU)
	{	
		Player.Grounded = false;
		Player.OnObject = false;
	}