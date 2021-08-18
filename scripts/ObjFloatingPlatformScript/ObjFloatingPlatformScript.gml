function ObjFloatingPlatformScript()
{	
	// Lower the platform if player is standing on it
	if Player.OnObject == id
	{
		Weight += 0.25;

		if DoFall
		{
			if !FallState
			{
				if (++FallTimer) == 30
				{
					FallState = true;
					object_set_range(RangeFar, TypeDelete);
					Player.OnObject = false;
				}
			}
			else
			{
				Player.OnObject = false;
			}	
		}
	}
	else
	{
		Weight -= 0.25;
	}
	Weight = clamp(Weight, 0, 3);
	
	if FallState 
	{
		FallSpeed += 0.21875;
		OriginY += FallSpeed;
		
		if OriginY >= Screen.CameraY + Screen.Height + 224
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
				var xDir = Speed ? 1 : -1;
				PosX += dsin(Angle) * Distance * xDir;
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
	
	// Update physical position
	x = floor(PosX);
	y = floor(PosY + Weight);
	
	// Do collision
	object_act_solid(false, true, false);
}