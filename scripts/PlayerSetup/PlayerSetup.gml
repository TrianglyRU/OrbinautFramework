function PlayerSetup()
{	
	// Set character
	CharacterID	= Game.GlobalCharacter;
	
	// Set spawn properties
	var Spawn = Game.SavedCheckpoint != 0 ? Game.SavedCheckpoint : Spawnpoint;
	PosX	  = Spawn.x;
	PosY	  = Spawn.y;
	
	// Set sprite
	Facing	  = FacingRight;
	Animation = AnimIdle;
	DrawOrder = Spawn.depth;
	
	// Set basic constants
	Acc		= 0.046875;
	Dec		= 0.5;
	RollDec = 0.125;
	Jump	= 6.5;
	Grv		= 0.21875;
	TopAcc	= 6;
	
	// Set default flags
	Grounded	 = true;
	OnObject	 = false;
	Jumping		 = false;
	Rolling	     = false;
	Pushing		 = false;
	MovementLock = false;
	isSuper		 = false;
	SpindashRev  = -2;

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
	Score = Game.SavedScore;
	Lives = Game.SavedLives;
	Rings = 0;
}