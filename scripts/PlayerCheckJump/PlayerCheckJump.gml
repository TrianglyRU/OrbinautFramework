function PlayerCheckJump()
{	
	// Jump
	if Input.ABCPress
	{	
		// Do not jump if found the low ceiling
		if round(Angle/90) % 4 == RangeFloor
		{
			if tile_get_distance_v(floor(PosX - xRadius), floor(PosY - yRadius), false, true, Layer) < 6
			or tile_get_distance_v(floor(PosX + xRadius), floor(PosY - yRadius), false, true, Layer) < 6
			{
				exit;
			}
		}
	
		// Exit the code if we're trying to perform spindash or peelout
		if Inertia == 0
		{
			if Game.SpindashEnabled == true and Input.Down
			or Game.PeeloutEnabled  == true and CharacterID = CharSonic and Input.Up
			{
				exit;
			}
		}

		// Set speeds and flags
		Xsp     -= Jump * dsin(Angle);
		Ysp	    -= Jump * dcos(Angle);	
		Jumping  = true;	
		Grounded = false;
		OnObject = false;
		
		// Update radiuses
		yRadius = yRadiusRoll;
		xRadius	= xRadiusRoll;
		
		if Game.RolljumpControl == true
		{
			Rolling = false;
		}
		else
		{
			PosY += yRadiusDefault - yRadiusRoll;
		}
		
		// Set animation
		Animation = AnimRoll;
		
		// Play sound
		audio_sfx_play(sfxJump, false);
		
		// Return true if we jumped
		return Jumping
	}
}