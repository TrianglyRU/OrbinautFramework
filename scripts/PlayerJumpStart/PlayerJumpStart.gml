function PlayerJumpStart()
{	
	// Exit if no action button is pressed or special ability is active
	if !Input.ABCPress or SpindashRev != -1 or PeeloutRev != -1
	{
		exit;
	}

	// Check if there is a room between player's head and ceiling
	if Angle <= 45 or Angle >= 315
	{
		// Check for ceiling directly above if on the ground
		if tile_find_v(PosX - RadiusX, PosY - RadiusY, false, true, Layer)[0] < 6
		or tile_find_v(PosX + RadiusX, PosY - RadiusY, false, true, Layer)[0] < 6
		{
			exit;
		}
	}
	else if Angle >= 46.41 and Angle <= 133.59		
	{
		// Check for ceiling to the left if on the right wall
		if tile_find_h(PosX - RadiusY, PosY - RadiusX, false, true, Layer)[0] < 6
		or tile_find_h(PosX - RadiusY, PosY + RadiusX, false, true, Layer)[0] < 6
		{
			exit;
		}
	}
	else if Angle >= 226.41 and Angle <= 313.59		
	{
		// Check for ceiling to the right if on the left wall
		if tile_find_h(PosX + RadiusY, PosY - RadiusX, true, true, Layer)[0] < 6
		or tile_find_h(PosX + RadiusY, PosY + RadiusX, true, true, Layer)[0] < 6
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
	PosY   += DefaultRadiusY - SmallRadiusY;
	
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
		
		/* In originals, it would set rolljump flag and reset radiuses, resulting in collision with floor and ceiling
		happening earlier. It is an oversight, so we fix that by updating radiuses in both cases */
	}
	
	// Play sound
	audio_sfx_play(sfxJump, false);
			
	// Return action result
	return Jumping;
}