/// @description Insert description here
// You can write your code in this editor
	
	RotationAngle = Stage.Time * Speed mod 360;
	
	var RAng = dsin(RotationAngle);
	XDist = dcos(90 + RAng * AngleX) * ChainDistance;
	YDist = dsin(90 + RAng * AngleY) * ChainDistance;
	var Count = ChainCount + 1;
	
	x = floor(OriginX + XDist * Count);
	y = floor(OriginY + YDist * Count);
	
	object_act_solid(false, true, false);