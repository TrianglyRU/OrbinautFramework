function ObjFloatingPlatformStartup()
{
	/* Variable Definitions	
	1. Speed,        default = 1
	2. Distance,     default = 64
	3. MovementType, default = "Static"
	4. Inverse,		 default = false
	*/
	
	// Setup object
	switch room
	{
		case Stage_TVZ:
		{
			var Solidbox = [40, 11];
			sprite_index = spr_obj_floatingplatform_tvz;
		}
		break;
		default:
		{
			var Solidbox = [0, 0];
			sprite_index = spr_tempobject;
		}
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