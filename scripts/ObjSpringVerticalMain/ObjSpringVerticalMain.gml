function ObjSpringVerticalMain()
{
	// Do collision
	object_act_solid(true, true, true, true);
		
	// Is player touching the launch side?
	if object_check_touch(image_yscale ? TypeSolidU : TypeSolidD)
	{	
		// Launch player
		Player.Ysp = -LaunchForce * image_yscale;
			
		// Clear flags
		if image_yscale
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
		
		// Reset animation
		animation_reset(1);
	}
}