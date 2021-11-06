function ObjSwingingPlatformStartup()
{
	/* Variable Definitions	
	1. ChainCount, default = 4
	2. Speed,	   default = 1
	*/
	
	// Set platform sprite and collision size
	switch room
	{
		case Stage_TZ:
		{
			XRadius		= 24;
			YRadius		= 8;
			SpriteData = [spr_obj_swingplatform_template, spr_tempobject, spr_tempobject];
		}
		break;
		default:
		{
			XRadius    = 0;
			YRadius    = 0;
			SpriteData = [spr_tempobject, spr_tempobject, spr_tempobject];
					  /* [platform,		  chain,		  pendulum] */
		}
		break;
	}
	
	// Set blank values
	DistanceX = 0;
	DistanceY = 0;

	// Set other variables
    OriginX   = x;
    OriginY   = y;
    Amplitude = (ChainCount + 2) * 16 + sprite_get_width(SpriteData[0]) div 2;
    
	// Set object solidbox
    object_set_solidbox(XRadius, YRadius, false);
	
	// Set object depth
    object_set_depth(Player, false);
}