/// @description Main
// You can write your code in this editor

	// Do collision
	object_act_solid(true, true, true, true);
		
	// Launch player
	if object_check_player(image_yscale ? ColSolidU : ColSolidD)
	{	
		if image_yscale
		{
			Player.Animation = AnimSpring;
		}
		else
		{
			Player.ClimbState = false;
			Player.Xsp        = 0;
		}
		Player.Ysp = -LaunchForce * image_yscale;
		
		animation_reset(1);
		audio_sfx_play(sfxSpring, false);
		
		// Player should be airborne now
		Player.Grounded = false;
		Player.OnObject = false;
	}