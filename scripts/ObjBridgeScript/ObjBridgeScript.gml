function ObjBridgeScript()
{
	// Get player's and AI position withtin the bridge
	var PlayerPosition = (floor(Player.PosX) - (x - 8) + 16) div 16;
	//var AIPosition     = (floor(AI.PosX) - (x - 8) + 16) div 16;
	
    // Check who is closer to the centre of the bridge
	//if abs(floor(BridgeLength / 2) - PlayerPosition) < abs(floor(BridgeLength / 2) - AIPosition)
	{
		// Use segment player is standing on
		var CurrentSegment = clamp(PlayerPosition, 1, BridgeLength);
	}
	//else
	{
		// Use segment AI is standing on
		//var CurrentSegment = clamp(AIPosition, 1, BridgeLength);
	}
	
    // Set a recovery angle by checking if player or AI is standing on any log of this bridge
    if ds_list_find_index(LogID, Player.OnObject) >= 0
   // or ds_list_find_index(LogID, AI.OnObject) >= 0
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
        with BridgeLog
		{
			object_act_solid(false, true, false, false);
		}
        exit; 
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
        
        // Calculate and apply logs position for this bridge		
		LogID[| i].y = floor(y + (MaxDepression * dsin(floor(90 * (1 - Tension)))) * dsin(RecoveryAngle));
    }
    
    // Do collision with the bridge
    with BridgeLog 
	{
		object_act_solid(false, true, false, false);
	}
        
    // Force-disable balancing
    Player.Balancing = false;
    //AI.Balancing = false;
}