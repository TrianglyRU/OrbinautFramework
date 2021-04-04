/// @description Script
// You can call your scripts in this editor
	
	// Do collision
	object_do_collision(SolidAll, false);
	
	show_debug_message("Top: " + string(objTouchedTop));
	show_debug_message("left: " + string(objTouchedLeft));
	show_debug_message("right: " + string(objTouchedRight));
	show_debug_message("bot: " + string(objTouchedBottom));
	// Check if we're touching launch side
	/*if Player.Grounded
	{
		var launchSide = image_xscale ? SideRight : SideLeft;
		if object_check_touch(launchSide)
		{
			Player.MovementLock = 10;
			Player.Inertia		= 10 * image_xscale;
			Player.Facing		=	   image_xscale;	
		}
	}*/