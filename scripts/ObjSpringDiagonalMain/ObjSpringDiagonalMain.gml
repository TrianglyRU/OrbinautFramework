function ObjSpringDiagonalMain()
{	
	// Do collision
	object_act_solid(true, true, true, true);
		
	// Is player touching the launch side?
	if (floor(Player.PosX + 4 * image_xscale) - x) * image_xscale >= 0 
	{		
		var LaunchSide = image_yscale ? SideTop : SideBottom;
		if object_check_touch(LaunchSide)
		{
			// Launch player
			Player.Xsp =  LaunchForce * image_xscale;
			Player.Ysp = -LaunchForce * image_yscale;	
			
			// Clear flags
			if LaunchSide == SideTop
			{
				Player.Animation  = AnimSpring;
				Player.ClimbState = false;
			}
			Player.Grounded = false;
			Player.OnObject = false;
			
			// Play spring sound
			audio_sfx_play(sfxSpring, false);	
		
			// Set animation
			animation_set(sprite_index, 3, 1, 3);
		}
	}
}