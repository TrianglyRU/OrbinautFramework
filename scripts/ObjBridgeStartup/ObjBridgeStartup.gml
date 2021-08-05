function ObjBridgeStartup()
{
	// Variables list
	RecoveryAngle    = 0;
	NativeY		     = 0;
	ActiveSegment    = 0;
	ActiveDepression = 0;
	LogDepression    = [];
	
	/* Variable Definitions	
	1. BridgeLength, default = 12
	2. BridgeSprite, default = spr_obj_bridgelog_template
	*/
	
	// Set log depression
	for (var i = 0; i < BridgeLength; i++) 
	{
		// Calculate log depression value
		LogDepression[i] = (i < BridgeLength / 2 ? i : BridgeLength - i - 1) * 2 + 2;
	}
	
	// Define native Y position
	NativeY = y;
	
	// Adjust X position
	x += (BridgeLength / 2 - 6) * 16;
	
	// Set bridge solidbox
	object_set_solidbox(BridgeLength / 2 * 16, 8, false);
	
	// Set active range
	object_set_range(RangeFar, false);
}