function PlayerCheckJump()
{	
	// Do not jump if found the low ceiling
	if round(Angle/90) % 4 = RangeFloor
	{
		if tile_get_data_v(floor(PosX - 9), floor(PosY - 25), Layer, false, 0) < 6
		or tile_get_data_v(floor(PosX + 9), floor(PosY - 25), Layer, false, 0) < 6
		{
			exit;
		}
	}
	
	// Exit the code if trying to spindash
	if Game.SpindashEnabled and Input.Down exit;
	if Game.PeeloutEnabled and Input.Up exit;

	// Jump
	if Input.ABCPress
	{	
		// Set speeds and flags
		Xsp     -= Jump * dsin(Angle);
		Ysp	    -= Jump * dcos(Angle);	
		Jumping  = true;	
		Grounded = false;
		OnObject = false;
		if (Game.RolljumpControl) Rolling = false;
		
		// Update radiuses
		yRadius = yRadiusRoll;
		xRadius	= xRadiusRoll;
		if (!Rolling) PosY += yRadiusDefault - yRadiusRoll;

		// Set animation
		Animation = AnimRoll;
		
		// Play sound
		audio_sfx_play(sfxJump, false);
		
		// Return true if we jumped
		return Jumping
	}
}