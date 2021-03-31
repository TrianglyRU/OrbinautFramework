function PlayerCheckClimb()
{
	// Check if we're Knuckles
	if CharacterID != CharKnuckles exit;
	
	// Perform attaching to the wall
	if ClimbingState == false
	{
		// Check if we're allowed to attach
		if GlidingState == 1 or GlidingState == 2
		{
			// Attach to the wall if moving towards it
			if Xsp > 0 and tile_get_distance_h(floor(PosX + 10), floor(PosY), true,  true, Layer) == 0
			or Xsp < 0 and tile_get_distance_h(floor(PosX - 10), floor(PosY), false, true, Layer) == 0
			{
				// Enter climbing state
				GlidingState  = false;
				ClimbingState = 1;
				Input.ABC	  = false;
				
				ClimbingAngle = 0;
				
				// Reset speeds
				Ysp	= 0;
				Grv	= 0;
			}
		}
	}
	
	// Climb
	else
	{
		// Set animation
		Animation = AnimClimb;
		
		if ClimbingAngle == 0
		{
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
		
			// Check if we do not find the wall anymore in front of us or we found the ground
			if tile_get_distance_v(floor(PosX + xRadius * Facing), floor(PosY + yRadiusDefault), true, false, Layer) == 0 
			or Facing == FacingRight and tile_get_distance_h(floor(PosX + xRadius), floor(PosY + yRadius), true,  true, Layer) > 0
			or Facing == FacingLeft  and tile_get_distance_h(floor(PosX - xRadius), floor(PosY + yRadius), false, true, Layer) > 0 
			{
				// Leave climbing state
				Ysp			  = 0;
				Grv			  = 0.21875;
				ClimbingState = false;
			
				// Set animation
				Animation = AnimGlideDrop;
			}
			
			// Check if we're near the top edge to climb on it
			else if Facing == FacingRight and tile_get_distance_h(floor(PosX + xRadius), floor(PosY - yRadius), true,  true, Layer) > 0
			or	    Facing == FacingLeft  and tile_get_distance_h(floor(PosX - xRadius), floor(PosY - yRadius), false, true, Layer) > 0
			{
				// TODO: Edge climbing
			}
				
			// Check if we pressed jump button
			if Input.ABCPress
			{
				// Enter jump state
				ClimbingState = false;
				Jumping		  = true;
			
				// Set speeds
				Grv =  0.21875;
				Ysp	= -4;
				Xsp	=  4 * -Facing;
			
				// Set animation
				Animation = AnimRoll;
				
				// Play sound
				audio_sfx_play(sfxJump, false);
			}
		}	
	}
}