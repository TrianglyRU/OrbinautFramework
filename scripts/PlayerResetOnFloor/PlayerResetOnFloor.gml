function PlayerResetOnFloor()
{	
	// If grounded flag has been set to true when we've been airborne, we have landed
	if !Grounded
	{
		exit;
	}
	
	// Set 'walk' animation if not in glide or climb state
	if GlideState != GlideStop and !ClimbState
	{
		Animation = AnimWalk;
	}
		
	// Reset gravity
	Grv	= 0.21875;
		
	// Reset flags
	Jumping			= false;
	Pushing			= false;
	Rolling			= false;
	GlideState      = false;
	GlideSlide      = false;
	ClimbState		= false;
	ScoreCombo		= false;
	BarrierIsActive = false;
		
	// Set visual angle
	if Angle >= 23.91 and Angle <= 337.5
	{
		VisualAngle = Angle;
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
		
	// Reset radiuses to default values
	if !Rolling
	{
		PosY   -= yRadiusDefault - yRadius;
		yRadius = yRadiusDefault; 
		xRadius	= xRadiusDefault;
	}
}