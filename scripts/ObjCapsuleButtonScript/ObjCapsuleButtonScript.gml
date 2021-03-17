function ObjCapsuleButtonScript()
{
	if !Pressed 
	{	
		// Play animation
		animation_play(spr_capsule_button, 3, 1);
		
		// Check if player is standing on the object
		if Player.OnObject = id
		{
			Stage.State = ActStateFinished;
			object_set_collision(SolidNone);
			y += 8;
			image_index = 0;
			Pressed = true;
		}
	}
}