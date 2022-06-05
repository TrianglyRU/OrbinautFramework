function PlayerJumpStart()
{	
	if !Input.ABCPress or SpindashRev != -1 or PeeloutRev != -1
	{
		return;
	}

	// Check if there is a room between player's head and ceiling above them
	switch CollisionMode[0]
	{
		case 0:
		{
			if tile_find_2v(PosX - RadiusX, PosY - RadiusY, PosX + RadiusX, PosY - RadiusY, false, noone, Layer)[0] < 6
			{
				return;
			}
		}
		break;
		case 1:
		{
			if tile_find_2h(PosX - RadiusY, PosY - RadiusX, PosX - RadiusY, PosY + RadiusX, false, noone, Layer)[0] < 6
			{
				return;
			}
		}
		break;
		case 2:
		{
			/* There is no check when on the actual ceiling! */
		}
		break;
		case 3:
		{
			if tile_find_2h(PosX + RadiusY, PosY - RadiusX, PosX + RadiusY, PosY + RadiusX, true, noone, Layer)[0] < 6
			{
				return;
			}
		}
		break;
	}
	
	Xsp			 += Jump * dsin(Angle);
	Ysp			 += Jump * dcos(Angle);	
	Pushing		  = false;
	Grounded      = false;
	OnObject	  = false;
	StickToConvex = false;
	Jumping       = true;
	Animation     = AnimSpin;
	RadiusX		  = DefaultRadiusX;
	RadiusY		  = DefaultRadiusY;

	if !Spinning
	{	
		PosY    += DefaultRadiusY - SmallRadiusY;
		RadiusX	 = SmallRadiusX;
		RadiusY  = SmallRadiusY;
		Spinning = true;
		
		/* Yes, originals seems to reset radiuses first and then set them once again. This
		leads to an oversight few lines below, fixed with the global.FixRollJump flag */		
	}
	else
	{
		if !global.RolljumpControl
		{
			AirLock = true;
		}
		
		// Sonic Team :|
		if global.FixRollJump
		{
			RadiusX	= SmallRadiusX;
			RadiusY = SmallRadiusY;
		}
	}
	audio_sfx_play(sfxJump, false);
			
	// Return action result
	return Jumping;
}