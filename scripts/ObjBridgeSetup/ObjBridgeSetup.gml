function ObjBridgeSetup()
{
	// Initialize variables
	RecoveryAngle  isVar;
	NativeY		   isVar;
	LogID		   isArr;
	LogDepression  isArr;
	
	/* Variable Definitions	
	1. BridgeLength, default = 12
	2. BridgeSprite, default = spr_obj_bridgelog_template
	*/
	
	// Create log list
	LogID = ds_list_create();
	
	// Set OddOffset
	var OddOffset = BridgeLength mod 2 == 0 ? 0 : 8;
	
	// Cycle through bridge length
	for (var i = 0; i < BridgeLength; i++) 
	{
		// Create log and set a sprite for it
	    var Log = instance_create((x - 6 * 16 + 8 - OddOffset) + 16 * i, y, BridgeLog);
	    Log.sprite_index = BridgeSprite;
		
		// Add log to the log list
		ds_list_add(LogID, Log);
		
		// Set object depth
		with Log object_set_depth(Player, false);
		
		// Calculate log depression value
		LogDepression[i] = (i < BridgeLength / 2 ? i : BridgeLength - i - 1) * 2 + 2;
	}
	
	// Set positions
	x += (BridgeLength / 2 - 6) * 16;
	NativeY = y;
	
	// Set bridge solidbox
	object_set_solidbox(BridgeLength / 2 * 16, 8);
}