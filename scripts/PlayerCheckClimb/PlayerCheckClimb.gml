function PlayerCheckClimb()
{
	// Exit the code if we do not play as Knuckles
	if CharacterID != CharKnuckles
	{
		exit;
	}
	
	// Exit the code if we've died
	if Death or Drown
	{
		exit;
	}
	
	// Are we not climbing yet?
	if !ClimbingState
	{
		// Check if we're gliding
		if GlidingState == GlidingAir
		{
			// Get tile in the direction we're moving to
			var TargetTile = tile_check_collision_h(floor(PosX + 10 * sign(Xsp)), floor(PosY), sign(Xsp), true, Layer);
			
			// Check if we're touching the wall and it is flat
			if TargetTile[0] < 0 and (TargetTile[1] == 90 or TargetTile[1] == 270)
			{
				// Stop gliding and start climbing
				ClimbingState = true;
				GlidingState  = false;
				Input.ABC	  = false;

				// Reset our speeds
				Xsp		= 0;
				Ysp	    = 0;
				Inertia = 0;
				
				// Reset gravity
				Grv = 0.21875;
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
				Ysp = -ClimbingSpeed;
			}
			else if Input.Down
			{
				Ysp = ClimbingSpeed;
			}
			else
			{
				Ysp = 0;
			}

			// Check if we do not find the wall in front of us
			if tile_check_collision_h(floor(PosX + xRadius * Facing), floor(PosY + yRadius), Facing, true, Layer)[0] > 0
			{
				// Leave climbing state
				Ysp			  = 0;
				ClimbingState = false;
			
				// Set 'drop' animation
				Animation = AnimGlideDrop;
				
				// Use normal collision radius
				xRadius = xRadiusDefault;
				yRadius = yRadiusDefault;
			}
			
			// Check if we found the ground below us
			else if Ysp > 0 and tile_check_collision_v(floor(PosX + xRadius * Facing), floor(PosY + yRadiusDefault), true, false, Layer)[0] < 0
			{
				// Leave climbing state
				Ysp	     = 0;
				Grounded = true;

				// Use normal collision radiuses
				xRadius = xRadiusDefault;
				yRadius = yRadiusDefault;	
			}
			
			// Check if we're near the edge to climb on it
			else if tile_check_collision_h(floor(PosX + xRadius * Facing), floor(PosY - yRadius - 1), Facing, true, Layer)[0] > 0
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
				while tile_check_collision_h(floor(PosX + xRadius * Facing), floor(PosY - yRadius), Facing, true, Layer)[0] > 0
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