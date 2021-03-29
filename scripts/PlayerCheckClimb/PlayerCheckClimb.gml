function PlayerCheckClimb()
{
	// Check if we're Knuckles
	if CharacterID != CharKnuckles exit;
	
	// Check if we're allowed to attach to the wall
	if !Climbing
	{
		if GlidingState = 1 or GlidingState = 2
		{
			// Attach to the wall if moving towards it
			if Xsp > 0 and tile_get_distance_h(floor(PosX + 10), floor(PosY), true,  true, Layer) = 0
			or Xsp < 0 and tile_get_distance_h(floor(PosX - 10), floor(PosY), false, true, Layer) = 0
			{
				GlidingState = false;
				Climbing	 = true;
				Ysp			 = 0;
				Grv			 = 0.21875;
				Input.ABC	 = false;
			}
		}
	}
	
	// Climb time!
	else
	{
		// Set animation
		Animation = AnimClimb;
		
		// Move up and down and all around
		if Input.Up
		{
			Ysp = -1;
		}
		else if Input.Down
		{
			Ysp = 1;
		}
		else
		{
			Ysp = 0;
		}
		
		// Stop climbing if there is no wall anymore
		if Facing = FacingRight and tile_get_distance_h(floor(PosX + 10), floor(PosY), true,  true, Layer) > 0
		or Facing = FacingLeft  and tile_get_distance_h(floor(PosX - 10), floor(PosY), false, true, Layer) > 0
		{
			Ysp		  = 0;
			Climbing  = false;
			Animation = AnimGlideDrop;
		}
		
		// Stop climbing if we jumped
		if Input.ABCPress
		{
			Animation = AnimRoll;
			Ysp			 = -4;
			Xsp			 = 4 * Facing * -1;
			Climbing	 = false;
			Jumping      = true;
		}
	}		
}