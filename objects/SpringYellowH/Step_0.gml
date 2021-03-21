/// @description Script
// You can call your scripts in this editor
	
	if Player.Grounded
	{
		var launchSide = image_xscale ? SideRight : SideLeft;
		if object_got_player(launchSide)
		{
			Player.MovementLock = 10;
			Player.Inertia		= 10 * image_xscale;
			Player.Facing		=	   image_xscale;	
		}
	}