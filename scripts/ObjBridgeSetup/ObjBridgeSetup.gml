function ObjBridgeSetup()
{
	// Initialize variables
	RecoveryAngle  isVar;
	LogID		   isArr;
	LogDepression  isArr;	
	
	/* Variable Definitions	
	1. BridgeLength, default = 12
	2. BridgeSprite, default = spr_obj_bridgelog_template
	*/
	
	// Create log list
	LogID = ds_list_create();
	
	// Cycle through bridge length
	for (var i = 0; i < BridgeLength; i++) 
	{
		// Create log and set a sprite for it
	    var Log = instance_create_depth(x + 16 * i, y, depth, BridgeLog);
	    Log.sprite_index = BridgeSprite;
		
		// Add log to the log list
		ds_list_add(LogID, Log);
		
		// Setup the log
		with Log 
		{
			// Set object hitbox
			object_set_solidbox(8, 8);
			
			// Set object depth
			object_set_depth(Player, false);
		}
		
		// Calculate log depression value
		LogDepression[i] = (i < BridgeLength / 2 ? i : BridgeLength - i - 1) * 2 + 2;
	}
}