function PlayerJumpStart()
{	
	// Jump
	if Input.ABCPress
	{	
		// Do not jump if found the low ceiling
		if Angle <= 45 or Angle >= 315
		{
			if tile_check_collision_v(floor(PosX - RadiusX), floor(PosY - RadiusY), false, true, Layer)[0] < 6
			or tile_check_collision_v(floor(PosX + RadiusX), floor(PosY - RadiusY), false, true, Layer)[0] < 6
			{
				exit;
			}
		}
	
		// Exit the code if we're trying to perform spindash or peelout
		if Inertia == 0
		{
			if Game.SpindashEnabled and Input.Down
			or Game.PeeloutEnabled  and CharacterID == CharSonic and Input.Up
			{
				exit;
			}
		}

		// Set speeds
		Xsp     += Jump * dsin(Angle);
		Ysp	    += Jump * dcos(Angle);	
		
		// Update flags
		Jumping       = true;	
		Grounded      = false;
		OnObject	  = false;
		StickToConvex = false;
		
		// Update radiuses
		if !Rolling
		{
			RadiusY = SmallRadiusY;
			RadiusX	= SmallRadiusX;
			PosY   += DefaultRadiusY - SmallRadiusY;
		}
		
		// Set animation
		Animation = AnimRoll;
		
		// Play sound
		audio_sfx_play(sfxJump, false);
		
		// Return true if we jumped
		return Jumping
	}
}