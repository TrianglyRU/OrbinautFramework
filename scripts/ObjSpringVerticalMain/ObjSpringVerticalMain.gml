function ObjSpringVerticalMain()
{
	// Play animation
	if image_index > 0
	{
		animation_play(sprite_index, 3, 1);
	}
	else 
	{
		// Do collision
		object_act_solid(true, true, true);
			
		// Is player touching launch side?
		if object_player_touch(LaunchSide)
		{
			// Launch player
			Player.Inertia   = 0;
			Player.Grounded  = false;
			Player.OnObject  = false;		
			Player.Ysp		 = -LaunchForce * image_yscale;
			Player.Animation =  LaunchSide == SideTop ? AnimSpring : AnimMove;
			
			// Play spring sound
			audio_sfx_play(sfxSpring, false);	
		
			// Start animation
			image_index = 1;
		}	
	}
}