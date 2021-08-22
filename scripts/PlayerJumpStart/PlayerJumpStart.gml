function PlayerJumpStart()
{	
	// Exit if no action button is pressed or special ability is active
	if !Input.ABCPress or SpindashRev != -1 or PeeloutRev != -1
	{
		exit;
	}

	// Exit if found low ceiling
	if Angle <= 45 or Angle >= 315
	{
		if tile_check_collision_v(PosX - RadiusX, PosY - RadiusY, false, true, Layer)[0] < 6
		or tile_check_collision_v(PosX + RadiusX, PosY - RadiusY, false, true, Layer)[0] < 6
		{
			exit;
		}
	}
	else if Angle >= 46.41 and Angle <= 133.59		
	{
		if tile_check_collision_h(PosX - RadiusY, PosY - RadiusX, false, true, Layer)[0] < 6
		or tile_check_collision_h(PosX - RadiusY, PosY + RadiusX, false, true, Layer)[0] < 6
		{
			exit;
		}
	}
	else if Angle >= 135 and Angle <= 225		
	{
		if tile_check_collision_v(PosX - RadiusX, PosY + RadiusY, true, true, Layer)[0] < 6
		or tile_check_collision_v(PosX + RadiusX, PosY + RadiusY, true, true, Layer)[0] < 6
		{
			exit;
		}
	}
	else if Angle >= 226.41 and Angle <= 313.59		
	{
		if tile_check_collision_h(PosX + RadiusY, PosY - RadiusX, true, true, Layer)[0] < 6
		or tile_check_collision_h(PosX + RadiusY, PosY + RadiusX, true, true, Layer)[0] < 6
		{
			exit;
		}
	}
	
	// Set speeds
	Xsp += Jump * dsin(Angle);
	Ysp	+= Jump * dcos(Angle);	
		
	// Update flags
	Pushing		  = false;
	Grounded      = false;
	OnObject	  = false;
	StickToConvex = false;
	Jumping       = true;
	Animation     = AnimSpin;
	
	// Update collision radiuses
	RadiusX	= SmallRadiusX;
	RadiusY = SmallRadiusY;
	PosY  += DefaultRadiusY - SmallRadiusY;
	
	// Set spinning flag
	if !Spinning
	{	
		Spinning = true;
	}
	
	// Lock airborne control
	else
	{
		if !Game.RolljumpControl
		{
			AirLock = true;
		}
		PosY -= DefaultRadiusY - SmallRadiusY;
		
		/* In originals, rolljump flag is set and radiuses are reset, resulting in collision with floor and ceiling
		happening earlier. It is an oversight, so we fix that by updating radiuses in both cases */
	}
	
	// Play sound
	audio_sfx_play(sfxJump, false);
			
	// Return action result
	return Jumping
}