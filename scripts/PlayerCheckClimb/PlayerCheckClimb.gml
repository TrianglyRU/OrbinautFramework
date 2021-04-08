function PlayerCheckClimb()
{
	// Check if we're Knuckles
	if CharacterID != CharKnuckles exit;
	
	// Perform attaching to the wall
	if !ClimbingState
	{
		// Check if we're allowed to attach
		if GlidingState == 1 or GlidingState == 2
		{
			// Attach to the wall if moving towards it
			if Xsp > 0 and tile_check_collision_h(floor(PosX + 10), floor(PosY), true,  true, Layer)[0] == 0
			or Xsp < 0 and tile_check_collision_h(floor(PosX - 10), floor(PosY), false, true, Layer)[0] == 0
			{
				// Enter climbing state
				ClimbingState = 1;
				GlidingState  = false;
				Input.ABC	  = false;

				// Reset speeds
				Ysp	    = 0;
				Grv	    = 0;
				Inertia = 0;
			}
		}
	}
	
	// Main action
	else
	{
		// Set animation
		Animation = AnimClimb;
		
		// Climb on walls
		if ClimbingState == 1
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
		
			// Check if we do not find the wall anymore in front of us
			if Facing == DirRight and tile_check_collision_h(floor(PosX + xRadius), floor(PosY + yRadius + 1), true,  true, Layer)[0] > 0
			or Facing == DirLeft  and tile_check_collision_h(floor(PosX - xRadius), floor(PosY + yRadius + 1), false, true, Layer)[0] > 0 
			{
				// Leave climbing state
				Ysp			  = 0;
				Grv			  = 0.21875;
				ClimbingState = false;
			
				// Set animation
				Animation = AnimGlideDrop;
				
				// Return normal radiuses
				xRadius = xRadiusDefault;
				yRadius = yRadiusDefault;
			}
			
			// Check if we found ground below us
			else if tile_check_collision_v(floor(PosX + xRadius * Facing), floor(PosY + yRadiusDefault), true, false, Layer)[0] <= 0
			{
				// Leave climbing state
				Ysp			  = 0;
				Grv			  = 0.21875;
				ClimbingState = false;
				Grounded      = true;

				// Set animation
				Animation = AnimIdle;
				
				// Return normal radiuses
				xRadius = xRadiusDefault;
				yRadius = yRadiusDefault;	
			}
			
			// Check if we're near the top edge to climb on it
			else if Facing == DirRight and tile_check_collision_h(floor(PosX + xRadius), floor(PosY - yRadius - 1), true,  true, Layer)[0] > 0
			or	    Facing == DirLeft  and tile_check_collision_h(floor(PosX - xRadius), floor(PosY - yRadius - 1), false, true, Layer)[0] > 0
			{
				// Go to climbering state
				Ysp			   = 0;
				ClimbingValue  = 0;
				ClimbingState  = 2;
				
				// Disable collisions
				AllowCollision = false;
			}
				
			// Check if we pressed jump button
			else if Input.ABCPress
			{
				// Enter jump state
				ClimbingState = false;
				Jumping		  = true;
			
				// Set speeds
				Grv = 0.21875;
				Ysp	= -4;
				Xsp	= -4 * Facing;
			
				// Set animation
				Animation = AnimRoll;
				
				// Play sound
				audio_sfx_play(sfxJump, false);
			}
		}
		
		// Climbering on the edge
		else if ClimbingState == 2
		{
			// Set animation
			Animation = AnimClimbering;
			
			// Start timer
			ClimbingValue++;
			
			// First frame: adjust our position to be at edge of the tile
			if ClimbingValue < 7
			{
				while Facing == DirRight and tile_check_collision_h(floor(PosX + xRadius), floor(PosY - yRadius), true, true, Layer)[0]  > 0
				or    Facing == DirLeft  and tile_check_collision_h(floor(PosX - xRadius), floor(PosY - yRadius), false, true, Layer)[0] > 0
				{
					PosY += 1;
				}
			}
			
			// Frame 2
			else if ClimbingValue == 7
			{
				PosX += 3 * Facing;
				PosY -= 3;
			}
			
			// Frame 3
			else if ClimbingValue == 13
			{
				PosX += 9 * Facing;
				PosY -= 10;
			}
			
			// Frame 4
			else if ClimbingValue == 19
			{
				PosX -= 8 * Facing;
				PosY -= 12;
			}
			
			// Frame 5, enable collision
			else if ClimbingValue == 25
			{
				AllowCollision = true;
				Grounded	   = true;
				PosX		  += 8 * Facing;
				PosY		  += yRadiusDefault - yRadius;
			}
		}
	}
}