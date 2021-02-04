function PlayerCheckJump()
{	
	// Do not jump if found the low ceiling
	if round(Angle/90 % 4) = RangeFloor
	{
		if colmask_meeting(floor(PosX - 9), floor(PosY - 25), true)
		or colmask_meeting(floor(PosX + 9), floor(PosY - 25), true) 
		{
			exit;
		}
	}
	
	// Exit the code if trying to spindash
	if Game.SpindashEnabled and Input.Down exit;

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
		sound_sfx_play(sfxJump, false);
	}	
}