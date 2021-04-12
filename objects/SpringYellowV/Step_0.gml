/// @description Script
// You can call your scripts in this editor
	
	// Do collision
	object_do_player_collision(SolidAll, false);
	
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
	}