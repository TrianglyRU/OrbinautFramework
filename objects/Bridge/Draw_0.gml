/// @description Draw
// You can write your code in this editor
	
	for (var i = 0; i < BridgeLength; i++)
    {   
        // Calculate bridge tension
		var Difference = abs((i + 1) - ActiveSegment);
		
        if i < ActiveSegment
        {
            var Tension = Difference / ActiveSegment;
        }
        else
        {
            var Tension = Difference / (BridgeLength - ActiveSegment + 1);
        }

		// Calculate log position and then draw it
		var LogX = (x - (BridgeLength / 2) * 16) + 16 * i + 8;
		var LogY = floor(NativeY + (ActiveDepression * dsin(floor(90 * (1 - Tension)))) * dsin(RecoveryAngle));
		
		draw_sprite(SpriteData[0], 0, LogX, LogY);
    }