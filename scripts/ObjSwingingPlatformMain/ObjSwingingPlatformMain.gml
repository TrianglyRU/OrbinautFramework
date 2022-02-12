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
	var Angle = dsin((abs(Speed * Stage.OscillateAngle) * Stage.Time) mod 360);
	DistanceX = dcos(90 + Angle * 90) * 16;
	DistanceY = dsin(90 + Angle * 90) * 16;
	
	// Calculate final position
	x = floor(OriginX + DistanceX * (ChainCount + 0.5));
	y = floor(OriginY + DistanceY * (ChainCount + 0.5));
    
	// Do collision
	object_act_solid(false, true, false, false);
}