function ObjBridgeMain()
{
	// Get player position within the bridge
	var PlayerPos = (floor(Player.PosX) - (x - BridgeLength / 2 * 16 - 16)) div 16;

	// Set a recovery angle by checking if player is standing on any log of this bridge
    if Player.OnObject == id
    {    
        if RecoveryAngle < 90
		{
			RecoveryAngle += 5.625;
		}
    } 
    else if RecoveryAngle > 0
    {
        RecoveryAngle -= 5.625;
    }

	// Get current maximun depression
	ActiveSegment	 = clamp(PlayerPos, 1, BridgeLength);
	ActiveDepression = LogDepression[ActiveSegment - 1];
	
	// Update bridge position
	y = NativeY + floor(ActiveDepression * dsin(RecoveryAngle));
	
	// Do solid collision
	object_act_solid(false, true, false);
	
	// Update logs
	for (var i = 0; i < BridgeLength; i++)
    {   
        // Check for current log
        var log_difference = abs((i + 1) - ActiveSegment);
        
        // Set tension to the left
        if i < ActiveSegment
        {
            var Tension = log_difference / ActiveSegment;
        }
        
        // Set tension to the right
        else
        {
            var Tension = log_difference / (BridgeLength - ActiveSegment + 1);
        }

		// Calculate log position
		var LogX = (x - (BridgeLength / 2) * 16) + 8 + 16 * i;
		var LogY = floor(NativeY + (ActiveDepression * dsin(floor(90 * (1 - Tension)))) * dsin(RecoveryAngle));
		
		// Draw log
		with Log[i]
		{
			x = LogX;
			y = LogY;
		}
    }
}