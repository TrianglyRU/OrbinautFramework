function ObjFloatingPlatformStartup()
{
	/* Variable Definitions	
	1. Speed,        default = 1
	2. Distance,     default = 64
	3. MovementType, default = "None"
	4. InverseX,	 default = false
	5. InverseY,	 default = false
	6. DoFall,       default = false
	*/
	
	// Set platform sprite and collision size
	switch room
	{
		case Stage_TZ:
		{
			XRadius		 = 32;
			YRadius		 = 11;
			sprite_index = spr_obj_platform_tz;
		}
		break;
		default:
		{
			XRadius		 = 0;
			YRadius		 = 0;
			sprite_index = spr_tempobject;
		}
		break;
	}
	
	// Set blank values
	Weight    = 0;
	State     = 0;
	Timer     = 0;
	FallSpeed = 0;
	
	// Set other variables
	OriginX = x;
	OriginY	= y;
	
	// Set object solidbox
	object_set_solidbox(XRadius, YRadius, false);
	
	// Set object unload type
	object_set_unload(TypePause);
	
	// Set object depth
	object_set_depth(Player, false);
}