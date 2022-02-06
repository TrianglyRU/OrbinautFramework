function ObjSpringDiagonalMain()
{	
	// Do collision
	object_act_solid(true, true, true, true);
	
	if (floor(Player.PosX + 4 * image_xscale) - x) * image_xscale >= 0 
	{	
		// Launch player
		if object_check_touch(image_yscale ? TypeSolidU : TypeSolidD)
		{
			if image_yscale
			{
				Player.Animation  = AnimSpring;
				Player.ClimbState = false;
			}
			Player.Xsp =  LaunchForce * image_xscale;
			Player.Ysp = -LaunchForce * image_yscale;	
			
			animation_reset(1);
			audio_sfx_play(sfxSpring, false);	
			
			// Player should be airbone now
			Player.Grounded = false;
			Player.OnObject = false;
		}
	}
}