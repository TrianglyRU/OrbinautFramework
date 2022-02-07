function ObjPrisonButtonMain()
{
	if !State
	{	
		// Do collision
		object_act_solid(true, true, false, true);
		
		if object_check_touch(TypeSolidU)
		{	
			y           += 8;
			image_index  = 0;
			
			// Increment state
			State++;
		}
	}
	
	// Player should be airborne now
	else if object_check_touch(TypeSolidU)
	{	
		Player.Grounded = false;
		Player.OnObject = false;
	}
}