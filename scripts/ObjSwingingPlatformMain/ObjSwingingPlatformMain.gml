function ObjSwingingPlatformMain()
{
	// Use custom unload boundaries
	if OriginX + Amplitude < Camera.ViewX or OriginX - Amplitude > Camera.ViewX + Game.Width 
	or OriginY + Amplitude < Camera.ViewY or OriginY - Amplitude > Camera.ViewY + Game.Height
	{
		Unload = true;
	}
	else
	{
		Unload = false;
	}
     
	// Do not run the code below if unloaded
	if Unload
	{
		exit;
	}
	
	// Set rotation angle
	RotationAngle = Stage.Time * Speed mod 360;
	
	// Move platform
	var Angle = dsin(RotationAngle);
	XDist     = dcos(90 + Angle * AngleX) * ChainSize;
	YDist     = dsin(90 + Angle * AngleY) * ChainSize;
		
	// Update position
	var Count = ChainCount + 1;
	x = floor(OriginX + XDist * Count);
	y = floor(OriginY + YDist * Count);
    
	// Do collision
	object_act_solid(false, true, false, false);
}