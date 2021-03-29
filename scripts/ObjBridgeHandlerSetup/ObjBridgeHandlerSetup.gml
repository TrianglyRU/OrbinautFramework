function ObjBridgeHandlerSetup()
{
	LogID = ds_list_create();
	for (var i = 0; i < BridgeLength; i++) 
	{
		// Create log and set a sprite for it
	    var Log          = instance_create_depth(x + 8 + 16 * i, y + 8, depth, BridgeLog);
		ds_list_add(LogID, Log);
	    Log.sprite_index = BridgeSprite;
		
		// Calculate log depression value
		LogDepression[i] = (i < BridgeLength / 2 ? i : BridgeLength - i - 1) * 2 + 2;
		
		// Setup the log
		with Log 
		{
			// Set object collision
			object_set_collision(SolidTop);
	
			// Set object depth
			object_set_depth(Player, false);
			
			// Set object hitbox
			object_set_hitbox(8, 8);
		}
	}	
	
	// Set default bridge recovery angle
	RecoveryAngle = 0;
}