function ObjFloatingPlatformStartup()
{
	/* Variable Definitions	
	1. XRadius,      default = 32
	2. YRadius,      default = 11
	3. Speed,        default = 1
	4. Distance,     default = 64
	5. MovementType, default = "None"
	6. InverseX,	 default = false
	7. InverseY,	 default = false
	8. DoFall,       default = false
	9. Sprite,       default = spr_obj_platform_template
	*/
	
	// Set blank values
	Weight    = 0;
	State     = 0;
	Timer     = 0;
	FallSpeed = 0;
	
	// Set other variables
	OriginX = x;
	OriginY	= y;

	// Set sprite
	sprite_index = Sprite;
	
	// Set object solidbox
	object_set_solidbox(XRadius, YRadius, false);
	
	// Set object unload type
	object_set_unload(TypePause);
	
	// Set object depth
	object_set_depth(Player, false);
}