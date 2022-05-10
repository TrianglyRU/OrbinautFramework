/// @description Main
// You can write your code in this editor
	
	// Get log number player is standing on
	var PlayerPos = (floor(Player.PosX) - (x - BridgeLength / 2 * 16 - 16)) div 16;

	// Set a recovery angle
    if object_check_player(ColSolidU)
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

	// Get current maximum depression
	ActiveSegment	 = clamp(PlayerPos, 1, BridgeLength);
	ActiveDepression = LogDepression[ActiveSegment - 1];
	
	// Update bridge position
	y = NativeY + floor(ActiveDepression * dsin(RecoveryAngle));
	
	// Do collision
	object_act_solid(false, true, false, false);