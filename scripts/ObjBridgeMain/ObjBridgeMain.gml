function ObjBridgeMain()
{
	// Get player position within the bridge
	var PlayerPos = (floor(Player.PosX) - (x - BridgeLength / 2 * 16 - 16)) div 16;

	// Set a recovery angle by checking if player or AI is standing on any log of this bridge
    if object_player_stand(id)
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

	// Use segment player is standing on
	ActiveSegment = clamp(PlayerPos, 1, BridgeLength);

    // Get current maximun depression
	ActiveDepression = LogDepression[ActiveSegment - 1];
	
	// Update bridge position
	y = NativeY + floor(ActiveDepression * dsin(RecoveryAngle));
	
	// Do solid collision
	object_act_solid(false, true, false, false);
}