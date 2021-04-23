function ObjYellowSpringHScript()
{
	// Define launch side
	var launchSide = image_xscale ? SideRight : SideLeft;
	
	// Check if we're touching launch side
	if Player.Grounded
	{
		if object_check_touch(launchSide)
		{
			Player.MovementLock = 10;
			Player.Inertia		= image_xscale * 10;
			Player.Facing		= image_xscale;	
			
			// Play sound
			audio_sfx_play(sfxSpring, false, true);
			
			// Exit the script
			exit;
		}
	}
	
	// Do collision
	object_do_collision(SolidAll, false);
}