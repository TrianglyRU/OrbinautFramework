/// @description Main
// You can write your code in this editor
    
	// Calculate distances
	var Angle = Stage.OscillateAngle * Stage.Time / 2 + 180 * Inverse;
	
	DistanceX = dcos(dcos(Angle) * -90 + 90) * 16;
	DistanceY = dsin(dcos(Angle) * -90 + 90) * 16;
	
	// Calculate final position
	x = round(OriginX + DistanceX * (ChainCount + 0.5));
	y = round(OriginY + DistanceY * (ChainCount + 0.5));
    
	// Do collision
	object_act_solid(false, true, false, false);