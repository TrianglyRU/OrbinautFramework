function ObjCapsuleButtonScript()
{
	// Check if button hasn't been pressed
	if !Pressed 
	{	
		// Do collision
		object_act_solid(true, true, true, false);
		
		// Play animation
		animation_play(spr_capsule_button, 3, 1);
		
		// Check if player is standing on the object
		if object_player_touch(SideTop)
		{
			// Finish the act and tell the button it has been pressed
			y          += 8;
			image_index = 0;
			Stage.State = ActStateFinished;
			Pressed     = true;
		}
	}
	
	// Disable collisions if it has been pressed
	else
	{	
		object_act_solid(false, false, false, false);
	}
}