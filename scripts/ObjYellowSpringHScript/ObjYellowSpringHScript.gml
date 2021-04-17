function ObjYellowSpringHScript()
{
	// Check if we're touching launch side
	if Player.Grounded
	{
		var launchSide = image_xscale ? SideRight : SideLeft;
		if object_check_touch(launchSide)
		{
			Player.MovementLock = 10;
			Player.Inertia		= image_xscale * 10;
			Player.Facing		= image_xscale;	
		}
	}
	
	// Do collision
	//object_do_collision(SolidAll, false);
}