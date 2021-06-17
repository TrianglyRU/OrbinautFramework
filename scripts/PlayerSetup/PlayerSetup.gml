function PlayerSetup()
{	
	// Set character
	CharacterID	= Game.GlobalCharacter;
	
	// Default sprite setup
	Facing	  = DirRight;
	Animation = AnimIdle;
	DrawOrder = layer_get_depth("Objects");
	
	// Set basic constants
	Acc			  = 0.046875;
	Frc			  = 0.046875;
	AirAcc		  = 0.09375;
	RollFrc		  = 0.0234375;
	Dec			  = 0.5;
	RollDec		  = 0.125;
	Grv			  = 0.21875;
	TopAcc		  = 6;	
	ClimbingSpeed = 1;
	JumpMin		  = -4;
	Jump		  = CharacterID == CharKnuckles ? 6 : 6.5;
	
	// Set default flags
	AllowCollision = true;
	Grounded	   = true;
	PeeloutRev     = -1;
	SpindashRev    = -1;
	DropdashRev    = -1;
	
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
		yRadiusRoll    = 14;
		xRadiusRoll    = 7;
	}
	xRadius = xRadiusDefault;
	yRadius = yRadiusDefault;
	
	// Load stats
	Score    = Game.GlobalScore;
	Lives    = Game.GlobalLives;
	Emeralds = Game.GlobalEmeralds;
	Conts    = Game.GlobalConts;
	
	// Define spawn position
	if Game.SavedPosition == 0
	{
		if Game.StageTransitions
		{
			PosX = Spawnpoint.x + Game.StageTransitionData[0];
			PosY = Spawnpoint.y + Game.StageTransitionData[1] - yRadius;
		}
		else
		{
			PosX = Spawnpoint.x;
			PosY = Spawnpoint.y - yRadius;
		}		
	}
	else
	{
		PosX = Game.SavedPosition[0];
		PosY = Game.SavedPosition[1];
	}
	
	// Initialize recorded position datalist array
	RecordedPosX = ds_list_create();
	RecordedPosY = ds_list_create();
	for (var ind = 0; ind < 32; ind++) 
	{
		RecordedPosX[| ind] = PosX;
		RecordedPosY[| ind] = PosY;
	}
	
	// Create Tails' tails
	if (CharacterID == CharTails) instance_create(x, y, TailsObject);
}