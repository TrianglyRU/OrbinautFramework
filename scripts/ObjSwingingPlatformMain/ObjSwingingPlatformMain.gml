function ObjSwingingPlatformMain()
{
	// Use custom unload boundaries
	if OriginX + Amplitude < Camera.ViewX or OriginX - Amplitude > Camera.ViewX + global.Width 
	or OriginY + Amplitude < Camera.ViewY or OriginY - Amplitude > Camera.ViewY + global.Height
	{
		ProcessObject = false;
	}
	else
	{
		ProcessObject = true;
	}
	
	if !ProcessObject
	{
		return;
	}
	
	// Calculate distances
	var Angle = abs(Speed * Stage.OscillateAngle) * (Stage.Time + 60) mod 360;
	DistanceX = dcos(dcos(Angle) * 90 + 90) * 16;
	DistanceY = dsin(dcos(Angle) * 90 + 90) * 16;
	
	// Calculate final position
	x = floor(OriginX + DistanceX * (ChainCount + 0.5));
	y = floor(OriginY + DistanceY * (ChainCount + 0.5));
    
	// Do collision
	object_act_solid(false, true, false, false);
}