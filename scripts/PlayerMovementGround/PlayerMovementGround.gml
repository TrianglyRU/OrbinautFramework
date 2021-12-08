function PlayerMovementGround()
{	
	// Initialise static variable
	static SkidTime = 0;
	
	// Exit if charging a spindash or peelout
	if SpindashRev != -1 or PeeloutRev != -1
	{
		exit;
	}
	
	// Perform movement
	if !GroundLock 
	{
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
				if (Angle <= 45 or Angle >= 316.41) and Inertia >= 4
				{
					if Animation != AnimSkid
					{
						if Game.Character != CharKnuckles
						{
							SkidTime = 32;
						}
						else
						{
							SkidTime = 16;
						}
						Animation = AnimSkid;
						
						// Play sound
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
				if (Angle <= 45 or Angle >= 316.41) and Inertia <= -4
				{
					if Animation != AnimSkid
					{
						if Game.Character != CharKnuckles
						{
							SkidTime = 32;
						}
						else
						{
							SkidTime = 16;
						}
						Animation = AnimSkid;
						
						// Play sound
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
	
	// Define which animations should be priority over Idle animation
	switch Animation
	{
		case AnimDropStand:
		case AnimGlideStand:
			var AnimationPriority = true;
		break;
		default:
			var AnimationPriority = false;
		break;
	}
	
	// Set pushing animation
	if Pushing
	{
		Animation = AnimPush;
	}
	else
	{
		if Angle <= 45 or Angle >= 316.41
		{
			if Inertia == 0 and !AnimationPriority
			{
				// Set idle animation
				Animation = AnimIdle;
				
				// Set crouch or lookup animation
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
		if Inertia != 0
		{
			// If not skidding, use movement animation
			if Animation != AnimSkid
			{
				Animation = AnimMove;
			}
			else 
			{
				// Cancel skid animation by pressing movement button
				if Inertia > 0 and Input.Right or Inertia < 0 and Input.Left
				{
					Animation = AnimMove;
				}
				
				// Reset skid timer
				else if Inertia > 0 and Input.Left or Inertia < 0 and Input.Right
				{
					SkidTime = Game.Character != CharKnuckles ? 16 : 32;
				}
				
				// Cancel skid animation automatically
				if !(SkidTime--)
				{
					Animation = AnimMove;
				}
			}
		}
	}
}