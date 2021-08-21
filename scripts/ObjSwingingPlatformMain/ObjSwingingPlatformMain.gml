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
     
	// Do not run the code below is unloaded
	if !Unload
	{
		// Set rotation angle
		RotationAngle = Stage.Time * Speed mod 360;
		
		// Get rotation angle (in degrees) and chain amount
		var Angle = dsin(RotationAngle);
		var Count = ChainCount + 1;
		
		// Move platform
		XDist = dcos(90 + Angle * AngleX) * ChainSize;
		YDist = dsin(90 + Angle * AngleY) * ChainSize;
		
		// Update position
		object_update_position(OriginX + XDist * Count, OriginY + YDist * Count);
    
		// Do collision
		object_act_solid(false, true, false);
	}
}