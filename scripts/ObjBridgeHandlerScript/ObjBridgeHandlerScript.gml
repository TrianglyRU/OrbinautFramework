function ObjBridgeHandlerScript()
{
	// Get a log number player is standing on
	var PlayerPosition = (floor(Player.PosX) - x + 16) div 16;
	var CurrentSegment = clamp(PlayerPosition, 1, BridgeLength);
	
	// Set a recovery angle
	if PlayerPosition > 0 and PlayerPosition < BridgeLength + 1 and Player.OnObject
	{	
		if (RecoveryAngle < 90) RecoveryAngle += 5.625;
	} 
	else if RecoveryAngle > 0
	{
		RecoveryAngle -= 5.625;
	}
	
	// Get current maximun depression
	var MaxDepression = LogDepression[CurrentSegment - 1];
	
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
		
		// Calculate logs position
		var BridgeY	= y + 8;
		LogY[i]		= floor(BridgeY + ((MaxDepression) * dsin(90 * (1 - Tension))) * dsin(RecoveryAngle));
	}
	
	// Apply logs position for this bridge
	with BridgeLog
	{
		y = ParentBridge.LogY[LogID];
	}
}