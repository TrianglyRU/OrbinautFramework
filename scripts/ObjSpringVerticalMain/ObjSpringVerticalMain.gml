function ObjSpringVerticalMain()
{
	// Play animation
	if image_index > 0
	{
		animation_play(sprite_index, 3, 0);
	}
	else 
	{	
		// Do collision
		object_act_solid(true, true, true, true);
		
		// Get collision side
		var LaunchSide = image_yscale ? SideTop : SideBottom;
		
		// Is player touching launch side?
		if object_check_touch(LaunchSide)
		{	
			// Launch player
			Player.Ysp = -LaunchForce * image_yscale;
			
			// Clear flags
			if LaunchSide == SideTop
			{
				Player.Animation = AnimSpring;
			}
			else
			{
				Player.ClimbState = false;
				Player.Xsp        = 0;
			}
			Player.Grounded = false;
			Player.OnObject = false;
			
			// Play spring sound
			audio_sfx_play(sfxSpring, false);	
		
			// Start animation
			image_index = 1;
		}
	}
}