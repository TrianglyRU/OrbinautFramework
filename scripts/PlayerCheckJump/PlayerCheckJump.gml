function PlayerCheckJump()
{	
	// Jump
	if Input.ABCPress
	{	
		// Do not jump if found the low ceiling
		if round(Angle/90) % 4 == RangeFloor
		{
			if tile_check_collision_v(floor(PosX - xRadius), floor(PosY - yRadius), false, true, Layer)[0] < 6
			or tile_check_collision_v(floor(PosX + xRadius), floor(PosY - yRadius), false, true, Layer)[0] < 6
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

		// Set speeds and flags
		Xsp     -= Jump * dsin(Angle);
		Ysp	    -= Jump * dcos(Angle);	
		Jumping  = true;	
		Grounded = false;
		OnObject = false;
		
		// Update radiuses
		if !Rolling
		{
			yRadius = yRadiusRoll;
			xRadius	= xRadiusRoll;
		}
		else
		{
			PosY -= yRadiusDefault - yRadiusRoll;
		}
		
		// Set animation
		Animation = AnimRoll;
		
		// Play sound
		audio_sfx_play(sfxJump, false);
		
		// Return true if we jumped
		return Jumping
	}
}