function PlayerSetup()
{	
	// Set character
	CharacterID	= Game.Character;
	
	// Default sprite setup
	Facing	  = FlipRight;
	Animation = AnimIdle;
	DrawOrder = layer_get_depth("Objects");
	animation_set_frame(Animation, 1);
	
	// Set default flags
	AirTimer	   = 1800;
	AllowCollision = true;
	Grounded	   = true;
	PeeloutRev     = -1;
	SpindashRev    = -1;
	DropdashRev    = -1;
	DropdashFlag   = -1;
	
	// Set default gravity
	Grv	= 0.21875;
	
	// Set collision radiuses
	if Game.Character != CharTails
	{
		DefaultRadiusY = 19;
		DefaultRadiusX = 9;
		SmallRadiusY   = 14;
		SmallRadiusX   = 7;
	}
	else
	{
		DefaultRadiusY = 15;
		DefaultRadiusX = 9;
		SmallRadiusY   = 14;
		SmallRadiusX   = 7;
	}
	RadiusX = DefaultRadiusX;
	RadiusY = DefaultRadiusY;
	
	// Load score and lives
	Score = Game.Score;
	Lives = Game.Lives;
	
	// Initialize recorded position datalist array
	RecordedPosX = ds_list_create();
	RecordedPosY = ds_list_create();
		
	// Fill recorded position datalist array
	for (var Index = 0; Index < 32; Index++) 
	{
		RecordedPosX[| Index] = x;
		RecordedPosY[| Index] = y;
	}
	
	// Load player on global spawn position in case it exists
	if !array_equals(Game.PlayerPosition, [])
	{
		Player.PosX = Game.PlayerPosition[0];
		Player.PosY = Game.PlayerPosition[1];
	}
	
	// Create Tails' tails
	if CharacterID == CharTails
	{
		instance_create(x, y, TailsObject);
	}
}