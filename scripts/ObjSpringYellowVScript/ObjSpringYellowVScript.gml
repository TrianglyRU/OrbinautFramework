function ObjSpringYellowVScript()
{
	// Define launch side
	var launchSide = image_yscale ? SideTop : SideBottom;
	
	// Check if we're touching launch side
	if object_check_touch(launchSide)
	{
		// Reset flags
		Player.Grounded    = false;
		Player.OnObject    = false;
		Player.Jumping     = false;
		Player.FlyingState = false;
		
		// Launch upwards or downwards
		Player.Ysp = -10 * image_yscale;
		
		// Play sound
		audio_sfx_play(sfxSpring, false, true);
		
		// Do not perform collision function below
		exit;
	}
	
	// Do collision
	object_do_collision(SolidAll, false);
}