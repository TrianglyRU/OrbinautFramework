function PlayerSetup()
{	
	// Default sprite setup
	switch Game.Character
	{
		case CharSonic:
			sprite_index = spr_sonic_idle;
		break;
		case CharTails:
			sprite_index = spr_tails_idle;
		break;
		case CharKnuckles:
			sprite_index = spr_knuckles_idle;
		break;
	}
	Facing	  = FlipRight;
	DrawOrder = layer_get_depth("Objects");
	
	// Set flags and gravity
	AirTimer	   = 1800;
	AllowCollision = true;
	Grounded	   = true;
	PeeloutRev     = -1;
	SpindashRev    = -1;
	DropdashRev    = -1;
	DropdashFlag   = -1;
	Grv			   = 0.21875;
	
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
		
		// Also create Tails' tails
		instance_create(x, y, TailsObject);
	}
	RadiusX = DefaultRadiusX;
	RadiusY = DefaultRadiusY;
	
	// Load score and lives
	Score = Game.Score;
	Lives = Game.Lives;
	
	// Initialize recorded position datalist array
	RecordedPosX = ds_list_create();
	RecordedPosY = ds_list_create();
	
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
}