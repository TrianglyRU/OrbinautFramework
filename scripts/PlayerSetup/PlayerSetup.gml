function PlayerSetup()
{	
	// Set character
	CharacterID	= Game.Character;
	
	// Default sprite setup
	Facing	  = DirRight;
	Animation = AnimIdle;
	DrawOrder = layer_get_depth("Objects");
	
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
	Score    = Game.Score;
	Lives    = Game.Lives;
	Emeralds = Game.Emeralds;
	Conts    = Game.Continues;
	
	// Define spawn position
	if Game.PlayerPosition == 0
	{
		if Game.StageTransitionData[4] == true
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
		PosX = Game.PlayerPosition[0];
		PosY = Game.PlayerPosition[1];
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