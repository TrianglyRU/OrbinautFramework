function ObjSpringDiagonalMain()
{	
	// Play animation
	if image_index > 0
	{
		animation_play(sprite_index, 3, 0);
	}
	else
	{
		// Do collision
		object_act_solid(true, true, true);
		
		// Is player touching the launch side?
		if (floor(Player.PosX + 4 * image_xscale) - x) * image_xscale >= 0 and object_player_touch(LaunchSide)
		{
			// Launch player
			Player.Inertia   = 0;
			Player.Grounded  = false;
			Player.OnObject  = false;
			Player.Ysp		 = -LaunchForce * image_yscale;
			Player.Xsp       =  LaunchForce * image_xscale;
			Player.Animation =  LaunchSide == SideTop ? AnimSpring : AnimWalk;
			
			// Play spring sound
			audio_sfx_play(sfxSpring, false)	
		
			// Start animation
			image_index = 1;
		}
	}
}