function ObjSwingingPlatformMain()
{
	// Use custom unload boundaries
	if OriginX + Amplitude < Camera.ViewX or OriginX - Amplitude > Camera.ViewX + Game.Width 
	or OriginY + Amplitude < Camera.ViewY or OriginY - Amplitude > Camera.ViewY + Game.Height
	{
		ProcessObject = false;
	}
	else
	{
		ProcessObject = true;
	}
     
	// Exit if object is unloaded
	if !ProcessObject
	{
		exit;
	}
	
	// Update oscillate angle
	var Angle = dsin((abs(Speed * 1.425) * Stage.Time) mod 360);
	
	// Calculate distance
	DistanceX = dcos(90 + Angle * 90) * 16
	DistanceY = dsin(90 + Angle * 90) * 16;
	
	// Calculate final position
	x = floor(OriginX + DistanceX * (ChainCount + 0.5));
	y = floor(OriginY + DistanceY * (ChainCount + 0.5));
    
	// Do collision
	object_act_solid(false, true, false, false);
}