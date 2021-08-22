function ObjPrisonButtonMain()
{
	// Check if button hasn't been pressed
	if !Pressed 
	{	
		// Do collision
		object_act_solid(true, true, true, true);
		
		// Play animation
		animation_play(sprite_index, 3, 0);
		
		// Check if player is standing on the object
		if object_check_touch(SideTop)
		{
			Player.PosY += 8;	
			y           += 8;
			image_index  = 0;
			Pressed      = true;
		}
	}
	
	// Disable collisions
	else if Player.OnObject == id
	{	
		Player.Grounded = false;
		Player.OnObject = false;
	}
}