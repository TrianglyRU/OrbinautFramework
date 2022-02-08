function ObjSwingingPlatformStartup()
{
	/* Variable Definitions	
	1. ChainCount, default = 4
	2. Speed,	   default = 1
	*/
	
	// Setup object
	switch room
	{
		case Stage_TVZ:
		{
			var Solidbox = [24, 8];
			SpriteData   = [spr_obj_swing_tvz_platform, spr_obj_swing_tvz_chain, spr_obj_swing_tvz_pendulum];
		}
		break;
		default:
		{
			var Solidbox = [0, 0];
			SpriteData   = [spr_tempobject, spr_tempobject, spr_tempobject];
					    /* [platform,	    chain,	        pendulum] */
		}
		break;
	}
	
	// Initialise variables
	OriginX   = x;
    OriginY   = y;
	DistanceX = 0;
	DistanceY = 0;
    Amplitude = (ChainCount + 2) * 16 + sprite_get_width(SpriteData[0]) div 2;
    
	// Set object properties
	object_set_depth(Player, 0);
    object_set_solidbox(Solidbox[0], Solidbox[1], false); 
}