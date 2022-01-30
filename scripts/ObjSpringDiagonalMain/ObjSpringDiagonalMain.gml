function ObjSpringDiagonalMain()
{	
	// Do collision
	object_act_solid(true, true, true, true);
		
	// Is player touching the launch side?
	if (floor(Player.PosX + 4 * image_xscale) - x) * image_xscale >= 0 
	{		
		if object_check_touch(image_yscale ? TypeSolidU : TypeSolidD)
		{
			// Launch player
			Player.Xsp =  LaunchForce * image_xscale;
			Player.Ysp = -LaunchForce * image_yscale;	
			
			// Clear flags
			if image_yscale
			{
				Player.Animation  = AnimSpring;
				Player.ClimbState = false;
			}
			Player.Grounded = false;
			Player.OnObject = false;
			
			// Play spring sound
			audio_sfx_play(sfxSpring, false);	
		
			// Reset animation
			animation_reset(1);
		}
	}
}