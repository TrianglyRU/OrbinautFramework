function ObjFloatingPlatformMain()
{	
	// Check if player is standing on the platform
	if Player.OnObject == id
	{
		// If fall flag is set, do fall after half a second
		if DoFall and !FallState
		{
			if (++FallTimer) == 30
			{
				FallState = true;
				FallTimer = 32;
				
				// Do not unload automatically
				object_set_range(false);
			}
		}
		
		// Lower the platform
		Weight += 0.25;
	}
	else
	{
		Weight -= 0.25;
	}
	Weight = clamp(Weight, 0, 4);
	
	// Increase fall speed
	if FallState 
	{
		FallSpeed += 0.21875;
		OriginY  += FallSpeed;
		
		// Make object lose the platform after 32 frames
		if !(--FallTimer) and Player.OnObject == id
		{
			Player.OnObject = false;
		}
		
		// Delete platform
		if OriginY > Stage.BottomBoundary
		{
			instance_destroy();
		}
	}
	
	var PosX = OriginX;
	var PosY = OriginY;
	
	// Check if platform has any movement pattern
	if !FallState and MovementType != "None"
	{
		// Update rotation angle
		Angle += Speed;
	
		// Update code position
		switch MovementType
		{
			case "Horizontal":
			{
				PosX += dcos(Angle) * Distance;
			}
			break;
			case "Vertical":
			{
				PosY += dsin(Angle) * Distance;
			}
			break;
			case "Diagonal":
			{
				var Direction = Speed ? 1 : -1;
				PosX += dsin(Angle) * Distance * Direction;
				PosY += dsin(Angle) * Distance;
			}
			break;
			case "Circular":
			{
				PosX += dcos(Angle) * Distance;
				PosY += dsin(Angle) * Distance;
			}
			break;
		}
	
		// Limit angle value
		Angle = Angle mod 360;
	}
	
	// Update position
	x = floor(PosX);
	y = floor(PosY + Weight);
	
	// Do collision
	object_act_solid(false, true, false, false);
}