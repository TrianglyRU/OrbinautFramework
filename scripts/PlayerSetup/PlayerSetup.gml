function PlayerSetup()
{	
	// Default sprite setup
	Player.Facing	 = FlipRight;
	Player.Animation = AnimIdle;
	Player.DrawOrder = layer_get_depth("Objects");
	
	// Set frame
	with Character
	{
		animation_set_frame(Player.Animation, 1);
	}
	
	// Set default flags
	Player.AirTimer	      = 1800;
	Player.AllowCollision = true;
	Player.Grounded		  = true;
	Player.PeeloutRev     = -1;
	Player.SpindashRev    = -1;
	Player.DropdashRev    = -1;
	
	// Set default gravity
	Player.Grv	= 0.21875;
	
	// Set collision radiuses
	if Game.Character != CharTails
	{
		Player.DefaultRadiusY = 19;
		Player.DefaultRadiusX = 9;
		Player.SmallRadiusY   = 14;
		Player.SmallRadiusX   = 7;
	}
	else
	{
		Player.DefaultRadiusY = 15;
		Player.DefaultRadiusX = 9;
		Player.SmallRadiusY   = 14;
		Player.SmallRadiusX   = 7;
		
		// Also create Tails Object
		instance_create(x, y, TailsObject);
	}
	Player.RadiusX = Player.DefaultRadiusX;
	Player.RadiusY = Player.DefaultRadiusY;
	
	// Load score and lives
	Player.Score = Game.Score;
	Player.Lives = Game.Lives;
	
	// If player uses global spawn position, use it
	if !array_equals(Game.PlayerPosition, [])
	{
		Player.PosX = Game.PlayerPosition[0];
		Player.PosY = Game.PlayerPosition[1];
	}
	
	// Initialize recorded position datalist array
	Player.RecordedPosX = ds_list_create();
	Player.RecordedPosY = ds_list_create();
		
	// Fill recorded position datalist array
	for (var Index = 0; Index < 32; Index++) 
	{
		Player.RecordedPosX[| Index] = 0;
		Player.RecordedPosY[| Index] = 0;
	}
}