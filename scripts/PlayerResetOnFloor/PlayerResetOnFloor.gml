function PlayerResetOnFloor()
{	
	// If grounded flag has been set to true when we've been airborne, we have landed
	if !Grounded
	{
		exit;
	}
	
	// Did we land with active water barrier?
	if BarrierIsActive and BarrierType == BarrierWater 
	{
		// Reset flags
		BarrierIsActive = false;
		Grounded        = false;
		
		// Set vertical speed
		Ysp	= -7.5 * dcos(Angle);
		
		// Set horizontal speed to vertical speed if floor is full steep
		if Angle >= 45 and Angle <= 315
		{
			Xsp = Angle <= 180 ? Ysp : -Ysp;
		}
		
		// Set horizontal speed to halved vertical speed if floor is half steep
		else if Angle >= 22.5 and Angle <= 337.5
		{
			Xsp = Angle <= 180 ? Ysp / 2 : -Ysp / 2;
		}
		
		// Reset horizontal speed if floor is shallow
		else 
		{	
			Xsp = 0;	
		}	
		
		// Play sound
		audio_sfx_play(sfxWaterBarrierBounce, false);
		
		// Exit the futher code
		exit;
	}	
	
	// Set 'walk' or 'run' animation if we've landed in roll state not on the object
	if Animation == AnimRoll and !OnObject
	{
		Animation = Inertia >= TopAcc ? AnimRun : AnimWalk;
	}
		
	// Reset gravity
	if !IsUnderwater
	{
		Grv	= 0.21875;
	}
	else
	{
		// Lower by 0x28 (0.15625) if underwater
		Grv = 0.0625
	}
	
	// Reset rolling flag if not rolling from the ground to object
	if !(OnObject and Ysp == 0)
	{
		Rolling = false;
	}
	
	// Reset other flags
	Jumping			= false;
	Pushing			= false;
	FlightState     = false;
	FlightValue	    = false;
	ScoreCombo		= false;
	BarrierIsActive = false;
	
	// Stop special player sfx
	audio_sfx_stop(sfxFlying);
	audio_sfx_stop(sfxTired);
	
	// Set visual angle
	if Angle >= 23.91 and Angle <= 337.5
	{
		VisualAngle = Angle;
	}
	else
	{
		VisualAngle = 360;
	}
		
	// Reset hurt state
	if Hurt
	{
		Hurt		 = false;
		IsInvincible = 121;	
		Inertia		 = 0;
	}
		
	// Perform Dropdash (if charged), else reset
	if DropdashRev == 20
	{	
		// Go to rolling state
		Rolling = true;
		
		// Set dropspeed
		if DropdashDirection == DirectionRight
		{
			var Dropspeed = Inertia / 4 + 8 * Facing;
		}
		else if DropdashDirection = DirectionLeft
		{
			if Angle == 360
			{
				var Dropspeed = 8 * Facing;
			}
			else
			{
				var Dropspeed = Inertia / 2 + 8 * Facing;
			}
		}
		Dropspeed = clamp(Dropspeed, -12, 12);
			
		// Apply dropspeed to inertia and set camera lag
		Inertia			   = Dropspeed;
		DropdashRev		   = -1;
		Screen.ScrollDelay = 16;
			
		// Set 'roll' animation
		Animation = AnimRoll;
	}
	else
	{
		DropdashRev = -1;
	}
		
	// Reset radiuses to default if not rolling, or on object
	if !Rolling
	{
		PosY   -= DefaultRadiusY - RadiusY;
		RadiusY = DefaultRadiusY; 
		RadiusX	= DefaultRadiusX;
	}
}