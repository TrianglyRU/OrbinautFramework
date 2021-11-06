function ObjBridgeDraw()
{
	// Draw posts
	if GeneratePosts
	{
		draw_sprite(SpriteData[1],     0, x - BridgeLength / 2 * 16 - 18, NativeY - 15);
		draw_sprite_ext(SpriteData[1], 0, x + BridgeLength / 2 * 16 + 18, NativeY - 15, -1, 1, 0, c_white, 1);
	}
	
	// Draw logs
	for (var i = 0; i < BridgeLength; i++)
    {   
        // Check for current log
        var Difference = abs((i + 1) - ActiveSegment);
        
        // Set tension to the left
        if i < ActiveSegment
        {
            var Tension = Difference / ActiveSegment;
        }
        
        // Set tension to the right
        else
        {
            var Tension = Difference / (BridgeLength - ActiveSegment + 1);
        }

		// Calculate log position
		var LogX = (x - (BridgeLength / 2) * 16) + 16 * i + 8;
		var LogY = floor(NativeY + (ActiveDepression * dsin(floor(90 * (1 - Tension)))) * dsin(RecoveryAngle));
		
		// Draw log
		draw_sprite(SpriteData[0], 0, LogX, LogY);
    }
}