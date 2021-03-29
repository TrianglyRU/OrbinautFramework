function PlayerCheckJump()
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
		if Game.SpindashEnabled && Input.Down 
		or Game.PeeloutEnabled  && Input.Up
		{
			exit;
		}
	}

	// Jump
	if Input.ABCPress = true
	{	
		// Set speeds and flags
		Xsp     -= Jump * dsin(Angle);
		Ysp	    -= Jump * dcos(Angle);	
		Jumping  = true;	
		Grounded = false;
		OnObject = false;
		if (Game.RolljumpControl == true) Rolling = false;
		
		// Update radiuses
		yRadius = yRadiusRoll;
		xRadius	= xRadiusRoll;
		if (Rolling == false) PosY += yRadiusDefault - yRadiusRoll;

		// Set animation
		Animation = AnimRoll;
		
		// Get our speed ratio
		AnimReservedSpeed = round(max(1, 4 - abs(Inertia)));
		
		// Play sound
		audio_sfx_play(sfxJump, false);
		
		// Return true if we jumped
		return Jumping
	}
}