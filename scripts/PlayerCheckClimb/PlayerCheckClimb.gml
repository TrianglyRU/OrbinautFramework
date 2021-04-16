function PlayerCheckClimb()
{
	// Check if we're Knuckles
	if CharacterID != CharKnuckles exit;
	
	// Attach to the wall if we're not climbing it yet
	if !ClimbingState
	{
		// Check if we're gliding normally, or turning
		if GlidingState == 1 or GlidingState == 2
		{
			// If found the wall and we were moving towards it
			if Xsp > 0 and tile_meeting(floor(PosX + 11), floor(PosY), Layer)
			or Xsp < 0 and tile_meeting(floor(PosX - 11), floor(PosY), Layer)
			{
				// Stop gliding and start climbing
				ClimbingState = true;
				GlidingState  = false;
				Input.ABC	  = false;

				// Reset our speeds
				Ysp	    = 0;
				Grv	    = 0;
				Inertia = 0;
			}
		}
	}
	
	// Climb action
	else
	{
		// Set 'climb' animation
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
		
			// Check if we do not find the wall in front of us
			if !tile_meeting(floor(PosX + 11 * Facing), floor(PosY + yRadius + 1), Layer)
			{
				// Leave climbing state
				Ysp			  = 0;
				Grv			  = 0.21875;
				ClimbingState = false;
			
				// Set 'drop' animation
				Animation = AnimGlideDrop;
				
				// Use normal collision radiuses
				xRadius = xRadiusDefault;
				yRadius = yRadiusDefault;
			}
			
			// Check if we found the ground below us
			else if tile_meeting(floor(PosX + xRadius * Facing), floor(PosY + yRadiusDefault + 1), Layer)
			{
				// Leave climbing state
				Ysp			  = 0;
				Grv			  = 0.21875;
				ClimbingState = false;
				Grounded      = true;

				// Set 'idle' animation
				Animation = AnimIdle;
				
				// Use normal collision radiuses
				xRadius = xRadiusDefault;
				yRadius = yRadiusDefault;	
			}
			
			// Check if we're near the edge to climb on it
			if !tile_meeting(floor(PosX + xRadius * Facing + 1), floor(PosY - yRadius - 1), Layer)
			{
				// Go to climbering state
				Ysp			   = 0;
				ClimbingValue  = 0;
				ClimbingState  = 2;
				
				// Disable all collisions
				AllowCollision = false;
			}
				
			// Check if we pressed A, B or C button
			else if Input.ABCPress
			{
				// Leave climbing state
				ClimbingState = false;
				Jumping		  = true;
			
				// Set speeds
				Grv = 0.21875;
				Ysp	= -4;
				Xsp	= -4 * Facing;
			
				// Set 'roll' animation
				Animation = AnimRoll;
				
				// Play sound
				audio_sfx_play(sfxJump, false);
			}
		}
		
		// Check if we're climbering on the edge
		else if ClimbingState == 2
		{
			// Set 'climbering' animation
			Animation = AnimClimbering;
			
			// Start climbering timer
			ClimbingValue++;
			
			// First frame: adjust our position to be at edge of the tile
			if ClimbingValue < 7
			{
				while !tile_meeting(floor(PosX + xRadius * Facing + 1), floor(PosY - yRadius), Layer)
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
			
			// Frame 5, enable collision and land
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