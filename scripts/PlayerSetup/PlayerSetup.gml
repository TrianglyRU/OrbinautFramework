function PlayerSetup()
{	
	// Default sprite setup
	switch Game.Character
	{
		case CharSonic:
		{
			sprite_index = spr_sonic_idle;
			image_speed  = 0;
		}
		break;
		case CharTails:
		{
			sprite_index = spr_tails_idle;
			image_speed  = 0;
		}
		break;
		case CharKnuckles:
		{
			sprite_index = spr_knuckles_idle;
			image_speed  = 0;
		}
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
	
	// Initialise recorded position datalist array
	RecordedPosX = ds_list_create();
	RecordedPosY = ds_list_create();
	
	for (var Index = 0; Index < 32; Index++) 
	{
		RecordedPosX[| Index] = x;
		RecordedPosY[| Index] = y;
	}
	
	// Set start position
	if !array_equals(Game.PlayerPosition, [])
	{
		PosX = Game.PlayerPosition[0];
		PosY = Game.PlayerPosition[1];
	}
	
	// If coming from special stage, load on ring's position
	if !array_equals(Game.SpecialRingData, [])
	{
		PosX = Game.SpecialRingData[0];
		PosY = Game.SpecialRingData[1];
	}
	
	/* If none of positions above exist, player will spawn
	on checkpoint. It is handled from its side! */
}