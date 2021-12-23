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
		// On the ground
		if tile_find_2v(PosX - RadiusX, PosY - RadiusY, PosX + RadiusX, PosY - RadiusY, false, true, noone, Layer)[0] < 6
		{
			exit;
		}
	}
	else if Angle >= 46.41 and Angle <= 133.59		
	{
		// On the right wall
		if tile_find_2h(PosX - RadiusY, PosY - RadiusX, PosX - RadiusY, PosY + RadiusX, false, true, noone, Layer)[0] < 6
		{
			exit;
		}
	}
	else if Angle >= 226.41 and Angle <= 313.59		
	{
		// On the left wall
		if tile_find_2h(PosX + RadiusY, PosY - RadiusX, PosX + RadiusY, PosY + RadiusX, true, true, noone, Layer)[0] < 6
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