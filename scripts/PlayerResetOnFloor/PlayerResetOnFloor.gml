function PlayerResetOnFloor()
{	
	// Wait until grounded flag is set. That means player has landed
	if !Grounded
	{
		return;
	}
	
	// Is water barrier active?
	if BarrierIsActive and BarrierType == BarrierWater 
	{
		var Force = IsUnderwater ? -4 : -7.5;
		Ysp		  = Force * dcos(Angle);
		Xsp       = Force * dsin(Angle);
		
		BarrierIsActive = false;
		Grounded        = false;
		OnObject	    = false;

		// Update barrier animation
		with Barrier
		{
			animation_play(spr_obj_barrier_water_bounce, [7, 13, 0], 0);
		}
		
		audio_sfx_play(sfxWaterBarrierBounce, false);
	}
	else
	{
		// Update player animation
		if !OnObject and Animation != AnimIdle
		{
			if Animation != AnimDropStand and Animation != AnimGlideStand
			{
				Animation = AnimMove;
			}
		}
		
		// Reset flags
		if !(OnObject and Ysp == 0)
		{
			Spinning = false;
		}
		if OnObject
		{
			Ysp = 0;
		}
		if Hurt
		{
			Hurt	= false;	
			Inertia = 0;
		}
		Jumping			 = false;
		AirLock			 = false;
		Pushing			 = false;
		FlightState		 = false;
		GlideState		 = false;
		ClimbState		 = false;
		ScoreCombo		 = false;
		BarrierIsActive  = false;
		DropdashFlag	 = DashLocked;
		DoubleSpinAttack = SpinReady;
		
		audio_sfx_stop(sfxFlying);
		audio_sfx_stop(sfxTired);
	
		// Update visual angle if floor is steep enough
		if Game.SmoothRotation and Angle > 33.75 and Angle < 326.25
		{
			VisualAngle = Angle;
		}
		
		// Reset gravity
		if !IsUnderwater
		{
			Grv = 0.21875;
		}
		else
		{
			// Reduce by 0x28 (0.15625) if underwater
			Grv = 0.0625
		}
		
		// Release/reset dropdash
		if DropdashRev == 20
		{	
			if RadiusY != SmallRadiusY
			{
				PosY   -= SmallRadiusY - RadiusY;
				RadiusX = SmallRadiusX;
				RadiusY = SmallRadiusY;
			}
			if SuperState
			{
				var DropForce = 12;
				var MaxForce  = 13;
			}
			else
			{
				var DropForce = 8;
				var MaxForce  = 12;
			}
		
			// Define dropspeed
			if DropdashSide == FlipRight
			{
				var Dropspeed = Inertia / 4 + DropForce * Facing;
			}
			else if DropdashSide == FlipLeft
			{
				if Angle == 360
				{
					var Dropspeed = DropForce * Facing;
				}
				else
				{
					var Dropspeed = Inertia / 2 + DropForce * Facing;
				}
			}
			Dropspeed = clamp(Dropspeed, -MaxForce, MaxForce);
			
			// Shake and/or delay camera
			if !Game.CDCamera
			{
				Camera.ScrollDelay = 16;
			}
			if SuperState
			{
				Camera.ShakeTime = 30;
			}
			
			// Apply dropspeed
			Inertia	    = Dropspeed;
			DropdashRev = -1;
			Spinning    = true;
			Animation   = AnimSpin;
			
			audio_sfx_stop(sfxDropDash);
			audio_sfx_play(sfxRelease, false);
			
			instance_create(PosX, PosY + RadiusY, DropdashDust);
		}
		else
		{
			DropdashRev = -1;
		}
	
		// Reset collision radiuses if not rolling
		if !Spinning
		{
			PosY   -= DefaultRadiusY - RadiusY;
			RadiusX	= DefaultRadiusX;
			RadiusY = DefaultRadiusY; 
		}
	}
}
