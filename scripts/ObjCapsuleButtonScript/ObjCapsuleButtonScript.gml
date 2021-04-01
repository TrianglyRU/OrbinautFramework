function ObjCapsuleButtonScript()
{
	if !Pressed 
	{	
		object_do_collision(SolidTop, false);
		
		// Play animation
		animation_play(spr_capsule_button, 3, 1);
		
		// Check if player is standing on the object
		if object_got_player(SideTop)
		{
			Stage.State = ActStateFinished;
			y += 8;
			image_index = 0;
			Pressed = true;
		}
	}
}