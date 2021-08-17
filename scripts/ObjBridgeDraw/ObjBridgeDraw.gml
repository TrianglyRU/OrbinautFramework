function ObjBridgeDraw()
{
	// Draw logs
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
		var LogX = (x - (BridgeLength / 2) * 16) + 16 * i + 8;
		var LogY = floor(NativeY + (ActiveDepression * dsin(floor(90 * (1 - Tension)))) * dsin(RecoveryAngle));
		
		// Draw log
		draw_sprite(BridgeSprite, 0, LogX, LogY);
    }
}