function ObjSpringHorizontalMain()
{
	// Do collision
	object_act_solid(true, true, true, false);
	
	// Launch player
	if Player.Grounded and object_check_touch(image_xscale ? ColSolidR : ColSolidL)
	{
		Player.Xsp	      = image_xscale * LaunchForce;
		Player.Facing     = image_xscale;	
		Player.Gsp    = Player.Xsp;
		Player.Pushing    = false;
		Player.GroundLock = 16;
		Player.Animation  = Player.Spinning ? AnimSpin : AnimMove;
			
		animation_reset(1);
		audio_sfx_play(sfxSpring, false);
	}
}