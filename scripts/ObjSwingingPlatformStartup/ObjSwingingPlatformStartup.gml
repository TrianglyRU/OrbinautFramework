function ObjSwingingPlatformStartup()
{
	/* Variable Definitions	
	1. XRadius,		   default = 24
	2. YRadius,		   default = 8
	3. ChainCount,	   default = 4
	4. Speed,		   default = 1
	5. SpritePlatform, default = spr_obj_swingplatform_template
	6. SpriteChain,	   default = spr_obj_swingchain_template
	7. SpriteTop,      default = spr_obj_swingtop_template
	*/
	
	// Set blank values
	DistanceX = 0;
	DistanceY = 0;

	// Set other variables
    OriginX   = x;
    OriginY   = y;
    Amplitude = (ChainCount + 2) * 16 + sprite_get_width(SpritePlatform) div 2;
    
	// Set object solidbox
    object_set_solidbox(XRadius, YRadius, false);
	
	// Set object depth
    object_set_depth(Player, false);
}