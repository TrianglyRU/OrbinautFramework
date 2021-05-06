function AISetup()
{	
	// Set character
	CharacterID	= CharTails;
	
	// Default sprite setup
	Facing	  = DirRight;
	Animation = AnimIdle;
	DrawOrder = Player.DrawOrder + 1;
	
	// Set basic constants
	Acc		= 0.046875;
	Frc     = 0.046875;
	AirAcc  = 0.09375;
	RollFrc = 0.0234375;
	Dec		= 0.5;
	RollDec = 0.125;
	Grv		= 0.21875;
	TopAcc	= 6;
	JumpMin = -4;
	Jump    = 6.5;
	
	// Set default flags
	AllowCollision = true;
	Grounded	   = true;
	OnObject	   = false;
	Jumping		   = false;
	Rolling	       = false;
	Pushing		   = false;
	Hurt		   = false;
	Death		   = false;
	MovementLock   = false;
	isSuper		   = false;
	isInvincible   = false;
	isUnderwater   = false;
	PeeloutRev     = -1;
	SpindashRev    = -1;
	DropdashRev    = -1;
	
	// Set collision radiuses
	yRadiusDefault = 15;
	xRadiusDefault = 9;
	yRadiusRoll    = 14;
	xRadiusRoll    = 7;	
	xRadius		   = xRadiusDefault;
	yRadius		   = yRadiusDefault;
	
	// Set spawn properties
	if Game.SavedPosition == 0
	{
		if Game.TransitionShiftPlayer[0] != 0
		{
			PosX = Spawnpoint.x + Game.TransitionShiftPlayer[0];
			PosY = Spawnpoint.y + Game.TransitionShiftPlayer[1] - yRadius;
		}
		else
		{
			PosX = Spawnpoint.x - 24;
			PosY = Spawnpoint.y - yRadius;
		}		
	}
	else
	{
		PosX = Game.SavedPosition[0];
		PosY = Game.SavedPosition[1];
	}

	// Create Tails' tails
	instance_create_depth(x, y, depth, TailsObject);
}