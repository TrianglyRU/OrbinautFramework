function ObjBridgeHandlerScript()
{
	object_do_collision(SolidTop, false);
	
	// Get a log number player is standing on
	var BridgeLeft	   = x - floor(BridgeLength / 2) * 16 - 16;
	var PlayerPosition = (floor(Player.PosX) - BridgeLeft) div 16;
	var CurrentSegment = clamp(PlayerPosition, 1, BridgeLength);
	
	if Player.OnObject == id
	{	
		var MaxDepression = LogDepression[CurrentSegment - 1];
		Player.PosY      = y - 8 + MaxDepression - Player.yRadius - 1;
		Player.Balancing = false;
	}
	
	/*
	
	// Set a recovery angle by checking if player is standing on any log of this bridge
	if ds_list_find_index(LogID, Player.OnObject) >= 0
	{	
		if (RecoveryAngle < 90) RecoveryAngle += 5.625;
	} 
	else if RecoveryAngle > 0
	{
		RecoveryAngle -= 5.625;
	}
	
	// Check for stepping onto the bridge
	else 
	{
		exit; 
	}
	
	// Bridge physics
	for (var i = 0; i < BridgeLength; i++)
	{	
		// Check for current log
		var log_difference = abs((i + 1) - CurrentSegment);
		
		// Set tension to the left
		if i < CurrentSegment
		{
			var Tension = log_difference / CurrentSegment;
		}
		
		// Set tension to the right
		else
		{
			var Tension = log_difference / (BridgeLength - CurrentSegment + 1);
		}
		
		// Calculate and apply logs position for this bridge
		var BridgeY	 = y;
		LogID[| i].y = floor(BridgeY + ((MaxDepression) * dsin(floor(90 * (1 - Tension)))) * dsin(RecoveryAngle));
	}

	// Do collision with the bridge
	with BridgeLog
	{
		object_do_collision(SolidTop, false);
		
		// Force-disable balancing
		Player.Balancing = false;
	}
	
	*/ 
}