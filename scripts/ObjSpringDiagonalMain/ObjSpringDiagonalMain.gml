function ObjSpringDiagonalMain()
{	
	// Is current frame different from 1?
	if animation_get_frame(id) > 1
	{
		// Play animation
		animation_play(sprite_index, 3, 1);
	}
	else
	{
		// Act solid
		object_act_solid(true, true, true);
		
		// Is player touching launch side?
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
			animation_set_frame(sprite_index, 2);
		}
	}
}