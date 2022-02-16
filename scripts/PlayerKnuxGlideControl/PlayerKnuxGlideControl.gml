function PlayerKnuxGlideControl()
{
	if GlideState == GlideAir
	{
		if Input.ABC
		{
			// Apply gravity
			if Ysp < 0.5
			{
				Grv = 0.125;
			}
			else if Ysp > 0.5
			{
				Grv = -0.125;
			}
			
			// Glide to the left
			if GlideDirection == FlipLeft
			{	
				if GlideValue > 0
				{
					GlideValue -= 2.8125;		
					Xsp	= GlideSpeed * dcos(GlideValue) * -sign(GlideSpeed);
				}
				else
				{
					Xsp = max(Xsp - GlideAcc, -24);
				}
				
				// Turn
				if Input.Right
				{
					if GlideValue == 0
					{
						GlideSpeed = Xsp;
					}
					GlideDirection = FlipRight;
				}
			}
		
			// Glide to the right
			else if GlideDirection == FlipRight
			{	
				if GlideValue < 180
				{
					GlideValue += 2.8125;
					Xsp	= GlideSpeed * dcos(GlideValue) * -sign(GlideSpeed);
				}
				else
				{
					Xsp = min(Xsp + GlideAcc, 24);
				}
				
				// Turn
				if Input.Left
				{
					if GlideValue == 180
					{
						GlideSpeed = Xsp;
					}
					GlideDirection = FlipLeft;
				}
			}
		
			// Set direction
			Facing = GlideValue > 90 ? FlipRight : FlipLeft;
		
			// Define animation frame
			if GlideValue < 120
			{
				if GlideValue > 60
				{
					GlideFrame = 2;
				}
				else if GlideValue > 30
				{
					GlideFrame = 1;
				}
				else
				{
					GlideFrame = 0;
				}
			}
			else if GlideValue < 150
			{
				GlideFrame = 1;
			}		
			else
			{
				GlideFrame = 0;
			}
		}
		else
		{
			// Enter fall state
			RadiusX	   = DefaultRadiusX;
			RadiusY	   = DefaultRadiusY;
			GlideState = GlideFall;
			Animation  = AnimGlideFall;
		
			// Reset gravity
			if !IsUnderwater
			{
				Grv	= 0.21875;
			}
			else
			{
				// Reduce by 0x28 (0.15625) if underwater
				Grv = 0.0625
			}
			Xsp *= 0.25;
		}
	}
	else if GlideState == GlideGround
	{
		// Decelerate
		if Xsp > 0
		{
			Xsp = max(0, Xsp - AirAcc);
		}
		else
		{
			Xsp = min(0, Xsp + AirAcc);
		}	
			
		// Stop sliding if not moving anymore or forced to roll
		if Xsp == 0 or !Input.ABC or ForcedRoll
		{
			if !Input.ABC
			{
				Xsp	= 0;
			}
				
			Animation  = AnimGlideStand;
			Grounded   = true;
			GroundLock = 16;
			
			PosY   -= DefaultRadiusY - RadiusY;
			RadiusX = DefaultRadiusX;
			RadiusY = DefaultRadiusY;
		}
					
		// Play sound each 8th frame while sliding
		else if (GlideValue++) mod 8 == 0
		{
			audio_sfx_play(sfxSlide, false);
		}
	}
}