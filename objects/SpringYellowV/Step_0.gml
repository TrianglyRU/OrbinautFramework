/// @description Script
// You can call your scripts in this editor
	
	// Define launch side
	var launchSide = image_yscale ? SideTop : SideBottom;
	
	// Check if we're touching launch side
	if object_got_player(launchSide)
	{
		// Reset flags
		Player.Grounded = false;
		Player.OnObject = false;
		Player.Jumping  = false;
		Player.Flying   = false;
		
		// Launch upwards or downwards
		Player.Ysp = -10 * image_yscale;
	}