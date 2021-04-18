function ObjSpringYellowVScript()
{
	// Define launch side
	var launchSide = image_yscale ? SideTop : SideBottom;
	
	// Check if we're touching launch side
	if object_check_touch(launchSide)
	{
		// Reset flags
		Player.Grounded      = false;
		Player.OnObject      = false;
		Player.Jumping       = false;
		Player.FlyingState   = false;
		Player.GlidingState  = false;
		Player.ClimbingState = false;
		
		// Set 'spring up' or 'walk' animation
		if launchSide = SideTop
		{
			Player.Animation = AnimSpringUp;
		}
		else
		{
			Player.Animation = AnimWalk;
		}
		
		// Launch upwards or downwards
		Player.Ysp = -10 * image_yscale;
		
		// Use normal collision radiuses
		Player.xRadius = Player.xRadiusDefault;
		Player.yRadius = Player.yRadiusDefault;
		
		// Play sound
		audio_sfx_play(sfxSpring, false, true);
	}
	
	// Do collision
	object_do_collision(SolidAll, false);
}