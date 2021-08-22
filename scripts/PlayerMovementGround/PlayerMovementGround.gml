function PlayerMovementGround()
{	
	if !GroundLock and !AirLock
	{
		// Left key is pressed?
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
				if (Angle <= 45 or Angle >= 315) and Inertia >= 4
				{
					if Animation != AnimSkid
					{
						Animation = AnimSkid;
						audio_sfx_play(sfxSkid, false);
						
						// Create dust object
						instance_create(floor(PosX), floor(PosY + RadiusY), DustPuff);
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
		
		// Right key is pressed?
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
				if (Angle <= 45 or Angle >= 315) and Inertia <= -4
				{
					if Animation != AnimSkid
					{
						Animation = AnimSkid;
						audio_sfx_play(sfxSkid, false);
						
						// Create dust object
						instance_create(floor(PosX), floor(PosY + RadiusY), DustPuff);
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
	
	// Set 'push' animation
	if Pushing
	{
		Animation = AnimPush;
	}
	else if Angle <= 45 or Angle >= 316.41
	{
		// Set 'crouch' animation
		if Game.SKCrouch
		{
			var CrouchCheck = abs(Inertia) < 1;
		}
		else
		{
			var CrouchCheck = Inertia == 0;
		}
		if CrouchCheck and Input.Down and (!Input.Left and !Input.Right)
		{
			if SpindashRev == -1 
			{
				Animation = AnimCrouch;
			}
		}
		
		// Set 'idle' or 'lookup' animation
		else if Inertia == 0
		{
			if PeeloutRev == -1
			{
				if Input.Up
				{
					Animation = AnimLookup;
				}
				else if !Input.Left and !Input.Right
				{
					Animation = AnimIdle;
				}
			}
		}
		
		// Set 'move' animation
		else if Animation != AnimSkid
		{
			Animation = AnimMove;
		}
		
		// Cancel skid animation if pressed control button in direction of our movement
		else if Inertia and Input.Right or !Inertia and Input.Left
		{
			Animation = AnimMove;
		}
	}
}