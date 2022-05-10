/// @description Startup
// You can write your code in this editor
	
	/* Variable Definitions	
	1. ChainCount, default = 4
	*/
	
	// Setup object
	switch room
	{
		case Stage_TSZ:
		{
			var Solidbox = [24, 8];
			SpriteData   = [spr_obj_swing_tsz_platform, spr_obj_swing_tsz_chain, spr_obj_swing_tsz_pendulum];
		}
		break;
		default:
		{
			var Solidbox = [0, 0];
			SpriteData   = [spr_controller_object, spr_controller_object, spr_controller_object];
					    /* [platform,			   chain,				  pendulum] */
		}
	}
	
	OriginX   = x;
    OriginY   = y;
	DistanceX = 0;
	DistanceY = 0;
    
	// Set object properties
	object_set_unload(FlagPause);
	object_set_depth(Player, 0);
    object_set_solidbox(Solidbox[0], Solidbox[1], false);