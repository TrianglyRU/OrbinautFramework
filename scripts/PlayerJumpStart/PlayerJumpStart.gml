function PlayerJumpStart()
{	
	// Jump
	if Input.ABCPress
	{	
		// Do not jump if found low celing
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
		
		// Exit the code if we're trying to perform spindash or peelout
		if Inertia == 0
		{
			if Game.SpindashEnabled and Input.Down
			or Game.PeeloutEnabled  and CharacterID == CharSonic and Input.Up
			{
				exit;
			}
		}
		
		// Reset collision radiuses
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
		
		// Are we not spinning yet?
		if !Spinning
		{
			// Enter spinning state
			Spinning = true;
			
			// Update collision radiuses
			PosY   += RadiusY - SmallRadiusY;
			RadiusY = SmallRadiusY;
			RadiusX	= SmallRadiusX;
		}
		else
		{
			// Set roll jump flag
			RollJumping = true;
			
			/* Notice that in this case radiuses won't update. 
			Why originals do that? No idea */
		}

		// Set animation
		Animation = AnimRoll;
		
		// Play sound
		audio_sfx_play(sfxJump, false);
		
		// Clear buttons
		Input.ABC	   = false;
		Input.ABCPress = false;
		
		// Return true if we jumped
		return Jumping
	}
}