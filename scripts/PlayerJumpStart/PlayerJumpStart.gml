function PlayerJumpStart()
{	
	// Exit if no action button is pressed or special ability is active
	if !Input.ABCPress or SpindashRev != -1 or PeeloutRev != -1
	{
		exit;
	}

	// Check if there is a room between player's head and ceiling (there is no check when on the ceiling)
	switch CollisionMode[0]
	{
		case 0:
		{
			if tile_find_2v(PosX - RadiusX, PosY - RadiusY, PosX + RadiusX, PosY - RadiusY, false, true, noone, Layer)[0] < 6
			{
				exit;
			}
		}
		break;
		case 1:
		{
			if tile_find_2h(PosX - RadiusY, PosY - RadiusX, PosX - RadiusY, PosY + RadiusX, false, true, noone, Layer)[0] < 6
			{
				exit;
			}
		}
		break;
		case 3:
		{
			if tile_find_2h(PosX + RadiusY, PosY - RadiusX, PosX + RadiusY, PosY + RadiusX, true, true, noone, Layer)[0] < 6
			{
				exit;
			}
		}
		break;
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