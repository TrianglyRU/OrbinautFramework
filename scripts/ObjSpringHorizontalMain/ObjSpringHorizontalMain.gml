function ObjSpringHorizontalMain()
{
	// Play animation
	if image_index > 0
	{
		animation_play(sprite_index, 3, 0);
	}
	else
	{	
		// Do collision
		object_act_solid(true, true, true, false);
		
		// Get collision side
		var LaunchSide = image_xscale ? SideRight : SideLeft;
		
		// Is player grounded and touching launch side?
		if Player.Grounded and object_check_touch(LaunchSide)
		{
			// Lock controls for 16 frames
			Player.GroundLock = 16;
			
			// Launch player
			Player.Xsp	   = image_xscale * LaunchForce;
			Player.Facing  = image_xscale;	
			Player.Inertia = Player.Xsp;
			Player.Pushing = false;
			
			// Play sound
			audio_sfx_play(sfxSpring, false);
			
			// Start animation
			image_index = 1;
		}
	}
}