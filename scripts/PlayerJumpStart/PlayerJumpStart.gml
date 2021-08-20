function PlayerJumpStart()
{	
	// Exit if no action button is pressed or special ability is active
	if !Input.ABCPress or SpindashRev != -1 or PeeloutRev != -1
	{
		exit;
	}

	// Exit if found low ceiling
	if Angle <= 45 or Angle >= 315
	{
		if tile_check_collision_v(floor(PosX - RadiusX), floor(PosY - RadiusY), false, true, Layer)[0] < 6
		or tile_check_collision_v(floor(PosX + RadiusX), floor(PosY - RadiusY), false, true, Layer)[0] < 6
		{
			exit;
		}
	}
	else if Angle >= 46.41 and Angle <= 133.59		
	{
		if tile_check_collision_h(floor(PosX - RadiusY), floor(PosY - RadiusX), false, true, Layer)[0] < 6
		or tile_check_collision_h(floor(PosX - RadiusY), floor(PosY + RadiusX), false, true, Layer)[0] < 6
		{
			exit;
		}
	}
	else if Angle >= 135 and Angle <= 225		
	{
		if tile_check_collision_v(floor(PosX - RadiusX), floor(PosY + RadiusY), true, true, Layer)[0] < 6
		or tile_check_collision_v(floor(PosX + RadiusX), floor(PosY + RadiusY), true, true, Layer)[0] < 6
		{
			exit;
		}
	}
	else if Angle >= 226.41 and Angle <= 313.59		
	{
		if tile_check_collision_h(floor(PosX + RadiusY), floor(PosY - RadiusX), true, true, Layer)[0] < 6
		or tile_check_collision_h(floor(PosX + RadiusY), floor(PosY + RadiusX), true, true, Layer)[0] < 6
		{
			exit;
		}
	}
	
	// Reset collision radiuses... to update them later?
	RadiusY = DefaultRadiusY;
	RadiusX	= DefaultRadiusX;

	// Set speeds
	Xsp += Jump * dsin(Angle);
	Ysp	+= Jump * dcos(Angle);	
		
	// Update flags
	Pushing		  = false;
	Grounded      = false;
	OnObject	  = false;
	StickToConvex = false;
	Jumping       = true;
	Animation     = AnimRoll;
	
	// Play sound
	audio_sfx_play(sfxJump, false);
	
	// If not spinning, enter spinning state
	if !Spinning
	{	
		// Update collision radiuses
		RadiusX	= SmallRadiusX;
		RadiusY = SmallRadiusY;
		PosY   += DefaultRadiusY - SmallRadiusY;
		
		// Set flag
		Spinning = true;
	}
	
	// Set roll jump flag
	else
	{
		/* Notice that in this case radiuses won't update. Why originals 
		do that? No idea, but it allows us to land a bit earlier */
		RollJumping = true;	
	}
			
	// Return action result
	return Jumping
}