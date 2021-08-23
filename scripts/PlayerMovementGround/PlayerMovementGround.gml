function PlayerMovementGround()
{	
	if !GroundLock and !AirLock
	{
		// Set skid angle range
		if !Game.S3SlopePhysics
		{
			// Notice that player won't skid on 315 degree slope
			var SkidRange = Angle <= 45 or Angle >= 316.41;	
		}
		else
		{
			/* In S3 you can skid on both 45 and 315 degree slope despite that the check is still the same. It it because those
			slopes are actually... shallower. In order not to force you to lower the angle of the tile, we'll do this: */
			var SkidRange = Angle <= 45 or Angle >= 315;
		}
		
		// Move left
		if Input.Left
		{	
			// Decelerate
			if Inertia > 0 
			{
				// Decelerate
				Inertia -= Dec;
				if Inertia <= 0
				{
					Inertia = -0.5;	
				}
				
				// Perform skid
				if SkidRange and Inertia >= 4
				{
					if Animation != AnimSkid
					{
						Animation = AnimSkid;
						audio_sfx_play(sfxSkid, false);
						
						// Create dust object
						instance_create(PosX, PosY + RadiusY, DustPuff);
					}
				}

			} 
			
			// Accelerate
			else
			{
				if Facing != FlipLeft
				{
					Facing  = FlipLeft;
					Pushing = false;
				}
				if !Game.GroundSpeedcap and Inertia > -TopAcc or Game.GroundSpeedcap
				{
					Inertia = max(Inertia - Acc, -TopAcc);
				} 
			}
		}
		
		// Move right
		else if Input.Right
		{			
			// Decelerate
			if Inertia < 0 
			{
				Inertia += Dec;
				if Inertia >= 0
				{
					Inertia = 0.5;
				}
				
				// Perform skid
				if SkidRange and Inertia <= -4
				{
					if Animation != AnimSkid
					{
						Animation = AnimSkid;
						audio_sfx_play(sfxSkid, false);
						
						// Create dust object
						instance_create(PosX, PosY + RadiusY, DustPuff);
					}
				}
			} 
			
			// Accelerate
			else
			{
				if Facing != FlipRight
				{
					Facing  = FlipRight;
					Pushing = false;
				}
				if !Game.GroundSpeedcap and Inertia < TopAcc or Game.GroundSpeedcap
				{
					Inertia = min(Inertia + Acc, TopAcc);
				} 
			}
		}
	}
	
	// Apply friction
	if !Input.Left and !Input.Right
	{
		if Inertia > 0
		{
			Inertia = max(Inertia - Frc, 0);
		}
		else
		{
			Inertia = min(Inertia + Frc, 0);
		}
		
		// Clear push flag
		Pushing = false;
	}
	
	// Convert inertia to speeds
	Xsp = Inertia *  dcos(Angle);
	Ysp = Inertia * -dsin(Angle);
	
	// Set animation
	if SpindashRev == -1 and PeeloutRev == -1
	{
		// Set pushing animation
		if Pushing
		{
			Animation = AnimPush;
		}
		else 
		{
			if Angle <= 45 or Angle >= 316.41
			{
				// Set idle animation
				if Inertia == 0
				{
					Animation = AnimIdle;
				}
			
				// Set crouch or lookup animation
				if Animation == AnimIdle
				{
					if Input.Up
					{
						Animation = AnimLookup;
					}
					else if Input.Down
					{
						Animation = AnimCrouch;
					}
				}
			}
		
			// If not skidding, use movement animation
			if Inertia != 0
			{
				if Animation != AnimSkid
				{
					Animation = AnimMove;
				}
				
				// Cancel skidding animation
				else if Inertia and Input.Right or !Inertia and Input.Left
				{
					Animation = AnimMove;
				}
			}
		}
	}
}