function ObjFloatingPlatformSetup()
{
	// Initialize variables
	OriginX   = 0;
	OriginY   = 0;
	Weight    = 0;
	Angle	  = 0;
	FallState = 0;
	FallTimer = 0;
	FallSpeed = 0;
	
	/* Variable Definitions	
	1. XRadius,    default = 30;
	2. YRadius,    default = 11;
	2. StartAngle, default = 0;
	4. Speed,      default = 0;
	5. Distance,   default = 0;
	6. Sprite,     default = spr_obj_platform_template;
	7. Movement,   default = "Horizontal";
	8. DoFall,     default = false;
	*/
	
	// Set object solidbox
	object_set_solidbox(XRadius, YRadius, false);
	
	object_set_range(RangeFar, ResetUnload);
	
	// Set object depth
	object_set_depth(Player, false);
	
	// Set sprite
	id.sprite_index = Sprite;
	
	// Set default position
	OriginX = x;
	OriginY = y;
	Angle   = StartAngle;
}