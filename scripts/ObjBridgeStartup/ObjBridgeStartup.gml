function ObjBridgeStartup()
{
	/* Variable Definitions	
	1. BridgeLength,  default = 12
	2. GeneratePosts, default = true
	*/
	
	// Setup object
	switch room
	{
		case Stage_TVZ:
			SpriteData = [spr_obj_bridge_log_tvz, spr_obj_bridge_post_tvz];
		break;
		default:
			SpriteData = [spr_tempobject, spr_tempobject];
					  /* [log,		      post] */
		break;
	}
	
	// Initialise variables
	x				 += (BridgeLength / 2 - 6) * 16;
	NativeY			 = y;
	RecoveryAngle    = 0;
	ActiveSegment    = 0;
	ActiveDepression = 0;
	
	// Calculate log depression value
	for (var i = 0; i < BridgeLength; i++) 
	{
		LogDepression[i] = (i < BridgeLength / 2 ? i : BridgeLength - i - 1) * 2 + 2;
	}
	
	// Set object properties
	object_set_unload(TypePause);
	object_set_depth(Player, 0);
	object_set_solidbox(BridgeLength / 2 * 16, 7, false);
	
	// Create bridge posts
	if SpawnPosts
	{
		var ThisObject = id;
		for (var i = 1; i > -2; i -= 2)
		{
			var  NewObject = instance_create(x - (BridgeLength / 2 * 16) * i - 18 * i, NativeY - 15, BridgePost);
			with NewObject
			{
				// Set object properties
				object_set_unload(TypePause);
				object_set_depth(Player, 1); 
				
				animation_set(ThisObject.SpriteData[1], 0); image_xscale = i;
			}
		}
	}
}