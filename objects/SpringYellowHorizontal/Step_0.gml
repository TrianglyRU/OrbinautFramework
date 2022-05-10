/// @description Main
// You can write your code in this editor

	// Do collision
	object_act_solid(true, true, true, false);
	
	// Check for overlap
	if !global.S2SpringBehaviour
	{
		var TouchCheck = object_check_player(image_xscale ? ColSolidR : ColSolidL);
	}
	else
	{
		var TouchCheck = object_check_player(image_xscale ? ColSolidR : ColSolidL)
					  or object_check_player(ColTrigger) and Player.Facing == image_xscale;			
	}
	
	// Launch player
	if Player.Grounded and TouchCheck
	{
		if image_index + 1 == image_number
		{
			Player.Xsp	      = image_xscale * LaunchForce;
			Player.Facing     = image_xscale;	
			Player.Gsp		  = Player.Xsp;
			Player.Pushing    = false;
			Player.GroundLock = 16;
			Player.Animation  = Player.Spinning ? AnimSpin : AnimMove;
			
			animation_reset(1);
			audio_sfx_play(sfxSpring, false);
		}
	}