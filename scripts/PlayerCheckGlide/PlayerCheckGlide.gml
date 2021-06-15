function PlayerCheckGlide()
{
	// Check if we're Knuckles
	if CharacterID != CharKnuckles or OnObject
	{
		exit;
	}
	
	// Start gliding
	if !GlidingState
	{
		// Check if we're jumping and A, B or C button is pressed
		if Jumping and Ysp > JumpMin and Input.ABCPress
		{
			// Set speeds
			if (Ysp < 0) Ysp = 0;
			Xsp	    = 4 * Facing;
			Inertia = 0;

			// Set unique gliding radiuses
			xRadius = 10;
			yRadius = 10;

			// Enter gliding state
			Jumping		     = false;
			GlidingValue	 = 0;
			GlidingDirection = Facing;
			GlidingState     = GlidingAir;
		}
	}
	
	// Check if we're in any of the gliding state
	else
	{
		// Override regular floor collision, get tiles
		var TileLeft  = tile_check_collision_v(floor(PosX - xRadius), floor(PosY + yRadius), true, false, Layer);
		var TileRight = tile_check_collision_v(floor(PosX + xRadius), floor(PosY + yRadius), true, false, Layer);
		
		// Use left tile (primary)
		if TileLeft[0] <= TileRight[0]
		{
			var floorDistance = TileLeft[0];
			var floorAngle    = TileLeft[1];
		}
		
		// Use right tile (secondary)
		else
		{
			var floorDistance = TileRight[0];
			var floorAngle    = TileRight[1];
		}
		
		// Get current gliding state
		switch GlidingState
		{
			// Check if we're gliding airborne
			case GlidingAir:
			{
				// Set 'glide' animation
				Animation = AnimGlide;
		
				// Accelerate
				Xsp += Facing * 0.015625;
				
				// Check for turning bacl
				if Input.LeftPress  and Facing == DirRight
				or Input.RightPress and Facing == DirLeft
				{
					// Start turning from right to left
					if Input.LeftPress
					{
						GlidingValue = 90
					}
					
					// Start turning from left to right
					else if Input.RightPress
					{
						GlidingValue = -90;
					}
					
					// Reserve horizontal speed
					ReservedSpeed = Xsp;
					
					// Enter turning state
					GlidingState = GlidingTurn;
				}
				
				// Apply gravity
				if Ysp < 0.5
				{
					Grv = 0.125;
				}
				else
				{
					Grv = -0.125;
				}
				
				// Drop down if no jump button is currently held
				if !Input.ABC
				{
					Xsp		    *= 0.25;
					GlidingState = GlidingDrop;		
				}
				
				// Enter sliding state if we collided the ground
				if floorDistance < 0
				{
					GlidingState = GlidingGround;
				}
			}
			break;
			
			// Check if we've glide dropped
			case GlidingDrop:
			{
				// Set 'glide drop' animation
				Animation = AnimGlideDrop;
				
				// Use regular gravity
				Grv = 0.21875;
				
				// Use default radiuses
				xRadius	= xRadiusDefault;
				yRadius	= yRadiusDefault;
				
				// Control character
				if Input.Left
				{
					Xsp -= AirAcc;
					Facing = DirLeft;
				}
				else if Input.Right
				{
					Xsp += AirAcc;
					Facing = DirRight;
				}
					
				// Check if we collide with the ground
				if floorDistance < 0
				{			
					// Adhere to the ground
					PosY += floorDistance;
					Angle = floorAngle;
					
					// Reset speeds
					Xsp     = 0;
					Inertia = 0;
					
					// Set flags
					Grounded     = true;
					MovementLock = 20;
				}
			}
			break;
			
			// Check if we're sliding
			case GlidingGround:
			{
				// Set 'glide slide' animation
				Animation = AnimGlideSlide;
				
				// Spawn dust puff every 4 frames
				SkiddingTimer = SkiddingTimer mod 4
				if !SkiddingTimer
				{
					instance_create(floor(PosX), floor(PosY + yRadius), DustPuff);
				}
				SkiddingTimer++;
			
				// Decelerate
				if Xsp > 0
				{
					Xsp = max(0, Xsp - AirAcc);
				}
				else
				{
					Xsp = min(0, Xsp + AirAcc);
				}
				
				// Get maximum collision distance
				var maxDistance = Game.SpeedFloorClip ? min(4 + abs(floor(Xsp)), 14) : 14;
				
				// Slide until we stop or release jump button
				if Xsp == 0 or !Input.ABC
				{
					GlidingState = GlidingStop;
					GlidingValue = 20;
				}
				
				// Adhere to the floor
				if floorDistance <= maxDistance
				{
					PosY += floorDistance;
					Ysp   = 0;
					Grv   = 0;
				}
				
				// Glide drop if we lost the ground
				else
				{
					GlidingState = GlidingDrop;
				}
			}
			break;
			
			// Check if we've stopped sliding
			case GlidingStop:
			{
				// Use 'glide stand' animation
				Animation = AnimGlideStand;
				
				// Reset speed
				Xsp = 0;
				
				// Use default radiuses
				PosY   -= yRadiusDefault - yRadius;
				xRadius = xRadiusDefault;
				yRadius = yRadiusDefault;
				
				// Adhere to the floor
				PosY += floorDistance;
				
				// Leave gliding state after 20 frames
				GlidingValue--
				if !GlidingValue
				{
					Grounded = true;
					Angle    = floorAngle;
				}
			}
			break;
			
			// Check if we're turning
			case GlidingTurn:
			{
				// Apply gravity
				Grv = Ysp < 0.5 ? 0.125 : -0.125;
				
				// Enter sliding state if we collided the ground
				if floorDistance < 0
				{
					GlidingState = GlidingGround;
					exit;
				}
		
				if GlidingDirection == DirRight
				{
					GlidingValue = max(GlidingValue - 2.8125, -90);
					if Input.RightPress
					{
						GlidingDirection = DirLeft;
						ReservedSpeed    = Xsp;
						break;
					}
					Xsp = ReservedSpeed * dsin(GlidingValue);
				
					if GlidingValue == -90
					{
						GlidingState     = GlidingAir;
						GlidingDirection = DirLeft;
					}
				}
				else if GlidingDirection == DirLeft
				{
					GlidingValue = min(GlidingValue + 2.8125, 90);
					if Input.LeftPress
					{
						GlidingDirection = DirRight;
						ReservedSpeed    = Xsp;
						break;
					}
					Xsp = ReservedSpeed * -dsin(GlidingValue);
				
					if GlidingValue == 90
					{
						GlidingState     = GlidingAir;
						GlidingDirection = DirRight;
					}
				}
				
				// Drop down if no jump button is currently held
				if !Input.ABC
				{
					Xsp		    *= 0.25;
					GlidingState = GlidingDrop;
				}
				
				// Set facing direction
				Facing = GlidingValue > 0 ? DirRight : DirLeft;
			}
			break;
		}		
	}
}