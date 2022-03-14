function ObjPlatformStartup()
{
	/* Variable Definitions	
	1. MovementType, default = "Stationary"
	*/
	
	// Setup object
	switch object_index
	{
		case PlatformTSZ:
			var Solidbox = [40, 11];
		break;
		default:
			var Solidbox = [0, 0];
	}
	
	// Initialise variables
	OriginX   = x;
	OriginY	  = y;
	Weight    = 0;
	State     = 0;
	Timer     = 0;
	FallSpeed = 0;
	FallFlag  = false;
	
	// Set object properties
	object_set_unload(FlagPause);
	object_set_depth(Player, 0);
	object_set_solidbox(Solidbox[0], Solidbox[1], false);
}