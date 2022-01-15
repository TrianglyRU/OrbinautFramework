function PlayerStartup()
{	
	// Initialise variables
	PosX				= 0;
	PosY				= 0;
	Acc					= 0;
	GlideAcc			= 0;
	Dec					= 0;
	Frc					= 0;
	RollFrc				= 0;
	AirAcc				= 0;
	RollDec				= 0;
	Jump				= 0;
	JumpMin				= 0;
	TopAcc				= 0;
	Xsp					= 0;
	Ysp					= 0;
	Inertia				= 0;
	SlopeGravity        = 0;
	Angle				= 0;	
	GroundLock			= 0;
	AirLock				= 0;
	ForcedRoll			= 0;
	Spinning			= 0;
	Jumping				= 0;
	Pushing             = 0;
	Grounded		    = 0;
	OnObject			= 0;
	PeeloutForce        = 0;
	DropdashSide	    = 0;
	SuperState			= 0;
	SuperStateValue	    = 0;
	GlideState			= 0;
	GlideValue			= 0;
	GlideSpeed			= 0;
	GlideDirection	    = 0;
	GlideFrame			= 0;
	ClimbState			= 0;
	ClimbValue			= 0;
	FlightState			= 0;
	FlightValue			= 0;
	HighspeedBonus	    = 0;
	InvincibleBonus	    = 0;
	InvincibilityFrames = 0;
	IsUnderwater	    = 0;
	BarrierType			= 0;
	BarrierIsActive     = 0;
	StickToConvex	    = 0;
	Hurt				= 0;
	Death				= 0;
	Drown				= 0;
	ScoreCombo			= 0;	
	Layer				= 0;
	VisualAngle			= 0;
	Animation			= 0;
	Rings				= 0;
	DebugMode           = 0;
	DebugItem			= 0;
	DebugSpeed			= 0;
	HitboxData			= [];
	
	// Set defaults
	DrawOrder		 = layer_get_depth("Objects");
	Facing			 = FlipRight;
	Grv			     = 0.21875;
	AirTimer	     = 1800;
	AllowCollision   = true;
	AllowMovement    = true;
	DoubleSpinAttack = SpinReady;
	DropdashFlag     = DashLocked;
	DropdashRev      = -1;
	PeeloutRev       = -1;
	SpindashRev      = -1;
	CollisionMode    = [0, 0];

	// Set default sprite
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
	
	// If respawning on checkpoint, load saved player data
	if array_length(Game.StarPostData)
	{
		PosX = Game.StarPostData[0];
		PosY = Game.StarPostData[1];
	}
	
	// If coming back from special stage, load saved player data
	if array_length(Game.SpecialRingData)
	{
		PosX  = Game.SpecialRingData[0];
		PosY  = Game.SpecialRingData[1];
		
		// Load saved ring and barrier
		if Game.SpecialRingData[3]
		{
			BarrierType = Game.SpecialRingData[3];
			instance_create(PosX, PosY, Barrier);
		}
		Rings = Game.SpecialRingData[2];
	}
	
	/* If none of the positions above exist, player will spawn
	on spawnpoint. It is handled from its side! */
	
	// If coming back from bonus stage, load saved rings and barrier
	if array_length(Game.BonusStageData)
	{
		Rings		= Game.BonusStageData[0];
		BarrierType = Game.BonusStageData[1];
		instance_create(PosX, PosY, Barrier);
		
		// Clear array
		Game.BonusStageData = [];
	}
	
	// Load score and lives
	Score		 = Game.Score;
	Lives		 = Game.Lives;
	LivesRewards = [(Rings div 100 * 100) + 100, (Score div 50000 * 50000) + 50000];
	
	// Initialise recorded position datalist
	RecordedPosX = ds_list_create();
	RecordedPosY = ds_list_create();
	
	for (var Index = 0; Index < 32; Index++) 
	{
		RecordedPosX[| Index] = x;
		RecordedPosY[| Index] = y;
	}
}