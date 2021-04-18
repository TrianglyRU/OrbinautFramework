function ObjBridgeHandlerSetup()
{
	object_set_solidbox(floor(BridgeLength / 2) * 16, 8);
	
	// Create log list
	LogID = ds_list_create();
	
	for (var i = 0; i < BridgeLength; i++) 
	{
		// Create log and set a sprite for it
	    var Log          = instance_create_depth((x + 8 + 16 * i) - (floor(BridgeLength/2) * 16), y, depth, BridgeLog);
	    Log.sprite_index = BridgeSprite;
		
		// Add log to the list
		ds_list_add(LogID, Log);
		
		// Setup the log
		with Log 
		{
			// Set object hitbox
			//object_set_solidbox(8, 8);
			
			// Set object depth
			//object_set_depth(Player, false);
		}
		
		// Calculate log depression value
		LogDepression[i] = (i < BridgeLength / 2 ? i : BridgeLength - i - 1) * 2 + 2;
	}	
	
	// Set default bridge recovery angle
	RecoveryAngle = 0;
}