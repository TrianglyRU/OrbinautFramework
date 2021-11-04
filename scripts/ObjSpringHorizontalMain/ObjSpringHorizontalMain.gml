function ObjSpringHorizontalMain()
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
		
		// Set animation
		Player.Animation = Player.Spinning ? AnimSpin : AnimMove;
			
		// Play sound
		audio_sfx_play(sfxSpring, false);
			
		// Reset animation
		animation_reset(1);
	}
}