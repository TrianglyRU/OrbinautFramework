function ObjFloatingPlatformStartup()
{
	/* Variable Definitions	
	1. XRadius,      default = 32
	2. YRadius,      default = 11
	2. StartAngle,   default = 0
	4. Speed,        default = 0
	5. Distance,     default = 0
	6. Sprite,       default = spr_obj_platform_template
	7. MovementType, default = "None"
	8. DoFall,       default = false
	*/
	
	// Set blank values
	Weight    = 0;
	State     = 0;
	Timer     = 0;
	FallSpeed = 0;
	
	// Set other variables
	OriginX	     = x;
	OriginY	     = y;
	Angle	     = StartAngle;
	sprite_index = Sprite;
	
	// Set object solidbox
	object_set_solidbox(XRadius, YRadius, false);
	
	// Set object unload type
	if MovementType == "None"
	{
		object_set_unload(TypePause);
	}
	
	// Set object depth
	object_set_depth(Player, false);
}