function PlayerMove()
{	
	// Accelerate and decelerate
	if MovementLock == false
	{
		if Input.Left
		{	
			// If moving right and left key is pressed, decelerate
			if Inertia > 0 
			{
				Inertia -= Dec;
				if (Inertia <= 0) Inertia = -0.5;	
			} 
			
			// If moving left and left key is pressed, accelerate
			else
			{
				if (!Game.GroundSpeedcap and Inertia > -TopAcc) or Game.GroundSpeedcap
				{
					Inertia = max(Inertia - Acc, -TopAcc);
				} 
				Facing = DirLeft;
			}
		}
		if Input.Right
		{				
			// If moving left and right key is pressed, decelerate
			if Inertia < 0 
			{
				Inertia += Dec;
				if (Inertia >= 0) Inertia = 0.5;
			} 
			
			// If moving right and right key is pressed, accelerate
			else
			{
				if (!Game.GroundSpeedcap and Inertia < TopAcc) or Game.GroundSpeedcap
				{
					Inertia = min(Inertia + Acc, TopAcc);
				} 
				Facing = DirRight;
			}
		}
	}
	
	// Apply friction
	if (!Input.Left and !Input.Right and Inertia != 0) or MovementLock != false
	{
		if Inertia > 0
		{
			Inertia = max(Inertia - Frc, 0);
		}
		else
		{
			Inertia = min(Inertia + Frc, 0);
		}
	}
	
	// Convert inertia to normal axis speeds
	Xsp = Inertia *  dcos(Angle);
	Ysp = Inertia * -dsin(Angle);
	
	// Check for start or stop skidding
	if Skidding == false 
	{
		if AngleQuadOdd == RangeFloor and MovementLock == false and abs(Inertia) > 4
		{
			// Define skidding direction
			if Inertia > 0 and Input.Left
			{
				Skidding = DirRight;
			
				// Play sound
				audio_sfx_play(sfxSkid, false);
			}
			if Inertia < 0 and Input.Right
			{
				Skidding = DirLeft;
			
				// Play sound
				audio_sfx_play(sfxSkid, false);
			}
		}
	}
	else
	{
		// Stop skidding
		if (Inertia < 0 and Input.LeftPress) or (Inertia > 0 and Input.RightPress) or Inertia == 0 or sign(Skidding) != sign(Inertia)
		{
			SkiddingTimer = 0;
			Skidding	  = false;
		}
	}
	
	// Check for stop pushing
	if Pushing == DirRight and !Input.Right
	or Pushing == DirLeft  and !Input.Left
	{
		Pushing = false;
	}
	
	// Check for stop balancing (balancing flag is set in floor collision)
	if Balancing != false and Inertia != 0
	{
		Balancing = false;
	}

	// Our default animation if AnimIdle
	if AngleQuadOdd == RangeFloor
	{
		Animation = AnimIdle;
	}
	
	// Act end animation
	if Stage.IsFinished == 2
	{
		Animation = AnimActEnd;
	}
		
	// Check if we're balancing to the right
	if Balancing == DirRight
	{
		Animation = AnimBalanceFront;
	}
	
	// Check if we're balancing to the left
	else if Balancing == DirLeft
	{
		Animation = AnimBalanceBack;
	}
		
	// Check if we're moving
	if Inertia != 0
	{
		// Check for walk
		if abs(Inertia) < 6
		{
			Animation = AnimWalk;
		}
		
		// Check for run
		else if abs(Inertia) < 10
		{
			Animation = AnimRun;
		}
		
		// Check for very fast run
		else
		{
			Animation = CharacterID == CharSonic and Game.PeeloutEnabled ? AnimPeelout : AnimRun;
		}
	}
		
	// Check if we're skidding
	if Skidding != false
	{
		// Spawn dust puff every 4 frames
		SkiddingTimer = SkiddingTimer mod 4
		
		if !SkiddingTimer
		{
			instance_create(floor(PosX), floor(PosY + yRadius), DustPuff);
		}
		SkiddingTimer++;
		
		// Play 'skid' animation
		Animation = AnimSkid;
	}
	
	// Check if we're pushing
	if Pushing != false
	{
		Animation = AnimPush;
	}
}