function ObjBridgeStartup()
{
	// Create variables
	RecoveryAngle    = 0;
	NativeY		     = 0;
	ActiveSegment    = 0;
	ActiveDepression = 0;
	LogDepression    = [];
	
	/* Variable Definitions	
	1. BridgeLength, default = 12
	2. BridgeSprite, default = spr_obj_bridgelog_template
	*/
	
	// Calculate log depression value
	for (var i = 0; i < BridgeLength; i++) 
	{
		LogDepression[i] = (i < BridgeLength / 2 ? i : BridgeLength - i - 1) * 2 + 2;
	}
	
	// Set default position
	x      += (BridgeLength / 2 - 6) * 16;
	NativeY = y;
	
	// Set object solidbox
	object_set_solidbox(BridgeLength / 2 * 16, 8, false);
	
	// Set object depth
	object_set_depth(Player, false);
	
	// Set object active range
	object_set_range(RangeFar, TypeUnload);
}