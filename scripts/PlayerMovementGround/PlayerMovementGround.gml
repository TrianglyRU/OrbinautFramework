function PlayerMovementGround()
{	
	static SkidTime = 0;
	
	if SpindashRev != -1 or PeeloutRev != -1
	{
		return;
	}
	
	if !GroundLock 
	{
		if Input.Left
		{	
			// Decelerate
			if Inertia > 0 
			{
				Inertia -= Dec;
				if Inertia <= 0
				{
					Inertia = -0.5;	
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
		
		// Perform skid. Angle check here is different in comparison to collision mode checks
		if (Angle <= 45 or Angle >= 316.41) and Animation != AnimSkid
		{
			if Input.Left and Inertia >= 4 or Input.Right and Inertia <= -4
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
						
				audio_sfx_play(sfxSkid, false);
				instance_create(PosX, PosY + RadiusY, DustPuff);
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
		Pushing = false;
	}

	// Convert inertia to speed
	Xsp = Inertia *  dcos(Angle);
	Ysp = Inertia * -dsin(Angle);
	
	// Define which animations should be in priority over the idle animation
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
	
	// Set animation
	if Pushing
	{
		Animation = AnimPush;
	}
	else if Inertia == 0
	{
		// Same unsymmetrical angle check, just like above...
		if (Angle <= 45 or Angle >= 316.41) and !AnimationPriority
		{
			if Input.Up
			{
				Animation = AnimLookup;
			}
			else if Input.Down
			{
				Animation = AnimCrouch;
			}
			else
			{
				Animation = AnimIdle;
			}
		}
	}
	else
	{
		if Animation != AnimSkid
		{
			Animation = AnimMove;
		}
		else 
		{
			if Inertia > 0 and Input.Right or Inertia < 0 and Input.Left
			{
				Animation = AnimMove;
			}
			else if Inertia > 0 and Input.Left or Inertia < 0 and Input.Right
			{
				SkidTime = Game.Character != CharKnuckles ? 16 : 32;
			}
			if !(SkidTime--)
			{
				Animation = AnimMove;
			}
		}
	}
}