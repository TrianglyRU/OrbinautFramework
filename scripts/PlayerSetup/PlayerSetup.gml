function PlayerSetup()
{	
	// Set character
	CharacterID	= Game.GlobalCharacter;
	
	// Set spawn properties
	if Game.SavedPosition = 0 
	{
		PosX = Spawnpoint.x;
		PosY = Spawnpoint.y;
	}
	else
	{
		PosX = Game.SavedPosition[0];
		PosY = Game.SavedPosition[1];
	}
	
	// Set sprite
	Facing	  = FacingRight;
	Animation = AnimIdle;
	DrawOrder = Spawnpoint.depth;
	
	// Set basic constants
	Acc		= 0.046875;
	Frc     = 0.046875;
	AirAcc  = Acc * 2;
	RollFrc = Frc / 2;
	Dec		= 0.5;
	RollDec = 0.125;
	Jump	= 6.5;
	Grv		= 0.21875;
	TopAcc	= 6;
	
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
	PeeloutRev     = -2;
	SpindashRev    = -2;
	DropdashRev    = -2;

	// Set collision radiuses
	if CharacterID != CharTails
	{
		yRadiusDefault = 19;
		xRadiusDefault = 9;
		yRadiusRoll    = 14;
		xRadiusRoll    = 7;
	}
	else
	{
		yRadiusDefault = 15;
		xRadiusDefault = 9;
		yRadiusRoll    = 13;
		xRadiusRoll    = 7;
	}
	xRadius = xRadiusDefault;
	yRadius = yRadiusDefault;
	
	// Stats
	Score    = Game.GlobalScore;
	Lives    = Game.GlobalLives;
	Emeralds = Game.GlobalEmeralds;
	Conts    = Game.GlobalConts;
}