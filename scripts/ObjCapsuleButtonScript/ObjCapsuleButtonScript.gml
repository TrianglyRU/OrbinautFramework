function ObjCapsuleButtonScript()
{
	// Check if button hasn't been pressed
	if !Pressed 
	{	
		// Do collision
		object_act_solid(true, true, true);
		
		// Play animation
		animation_play(sprite_index, 3, 1);
		
		// Check if player is standing on the object
		if object_player_touch(SideTop)
		{
			y          += 8;
			image_index = 0;
			Pressed     = true;
		}
	}
	
	// Disable collisions if it has been pressed
	else
	{	
		object_act_solid(false, false, false);
	}
}