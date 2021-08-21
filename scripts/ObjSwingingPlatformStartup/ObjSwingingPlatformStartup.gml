function ObjSwingingPlatformStartup()
{
	// Create variables
	OriginX   = 0;
	OriginY   = 0;
	XDist     = 0;
	YDist     = 0;
	Amplitude = 0;
	Unload    = 0;
	
	/* Variable Definitions	
	1. XRadius,		   default = 24
	2. YRadius,		   default = 8
	2. ChainCount,	   default = 4
	4. ChainSize,	   default = 16
	5. AngleX,		   default = 90
	6. AngleY,		   default = 90
	7. SpritePlatform, default = spr_obj_swingplatform_template
	8. SpriteChain,	   default = spr_obj_swingchain_template
	9. SpriteTop,      default = spr_obj_swingtop_template
	*/
	
	// Set default properties
    OriginX   = x;
    OriginY   = y;
    XDist     = 0;
    YDist     = 0;
    Amplitude = (ChainCount + 2) * ChainSize + sprite_get_width(SpritePlatform) div 2;
    
	// Set object solidbox
    object_set_solidbox(XRadius, YRadius, false);
	
	// Set object depth
    object_set_depth(Player, false);
}