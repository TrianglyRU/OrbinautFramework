function ObjSwingingPlatformMain()
{
	// Calculate distances
	var Angle = abs(Speed * Stage.OscillateAngle) * (Stage.Time + 60);
	DistanceX = dcos(dcos(Angle) * 90 + 90) * 16;
	DistanceY = dsin(dcos(Angle) * 90 + 90) * 16;
	
	// Calculate final position
	x = floor(OriginX + DistanceX * (ChainCount + 0.5));
	y = floor(OriginY + DistanceY * (ChainCount + 0.5));
    
	// Do collision
	object_act_solid(false, true, false, false);
}