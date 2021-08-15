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
		OnObject		= false;
		
		// Set vertical speed
		var Force = IsUnderwater ? -4 : -7.5;
		Ysp		  = Force * dcos(Angle);
		Xsp		  = Force * dsin(Angle);
		
		// Play sound
		audio_sfx_play(sfxWaterBarrierBounce, false);
		
		// Exit the further code
		exit;
	}
	
	// Set 'walk' or 'run' animation if we've landed on the solid ground
	if Spinning and !OnObject
	{
		Animation = Inertia >= TopAcc ? AnimRun : AnimWalk;
	}
	
	// Restore control (from hit)
	NoControls = false;
		
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
	
	// Clear the roll and skid flag
	if !(OnObject and Ysp == 0)
	{
		Spinning  = false;
		Skidding = false;
	}
	RollJumping = false;
	
	// Reset other action flags
	Jumping			= false;
	FlightState     = false;
	FlightValue	    = false;
	GlideState      = false;
	GlideValue      = false;
	GlideGrounded   = false;	
	ClimbState		= false;
	ClimbValue		= false;
	ScoreCombo		= false;
	BarrierIsActive = false;
	
	// Stop special player sfx
	audio_sfx_stop(sfxFlying);
	audio_sfx_stop(sfxTired);
	audio_sfx_stop(sfxSlide);
	
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
		Hurt	= false;	
		Inertia = 0;
	}
		
	// Perform Dropdash (if charged), else reset
	if DropdashRev == 20
	{	
		// Go to rolling state
		Spinning = true;
		
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
		
	// Reset radiuses to default
	if !Spinning
	{
		PosY   -= DefaultRadiusY - RadiusY;
		RadiusY = DefaultRadiusY; 
		RadiusX	= DefaultRadiusX;
	}
}