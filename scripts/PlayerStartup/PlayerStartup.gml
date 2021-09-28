function PlayerStartup()
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
	AllowMovement  = true;
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
	RadiusW = 10;				// Wall radius. It is 10 for everyone by default
	
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
	
	// If respawning on checkpoint, load saved player data
	if array_length(Game.StarPostData)
	{
		PosX  = Game.StarPostData[0];
		PosY  = Game.StarPostData[1];
	}
	
	// If coming from special stage, load saved player data
	if array_length(Game.SpecialRingData)
	{
		PosX  = Game.SpecialRingData[0];
		PosY  = Game.SpecialRingData[1];
		Rings = Game.SpecialRingData[2];
		
		// Restore barrier
		if Game.SpecialRingData[3]
		{
			BarrierType = Game.SpecialRingData[3];
			instance_create(PosX, PosY, Barrier);
		}	
	}
	
	/* If none of positions above exist, player will spawn
	on checkpoint. It is handled from its side! */
}