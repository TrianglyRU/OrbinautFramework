/// @description Main
// You can write your code in this editor
	
	if object_check_player(ColSolidU)
	{	
		if !State
		{	
			y           += 8;
			image_index  = 0;
			
			// Increment state
			State	    += 1;
			Player.PosY += 8;
		}
		else
		{
			// Clear solidbox
			object_set_solidbox(0, 0, false);
			
			Player.Grounded = false;
			Player.OnObject = false;
		}
	}
	
	// Do collision
	object_act_solid(true, true, false, true);