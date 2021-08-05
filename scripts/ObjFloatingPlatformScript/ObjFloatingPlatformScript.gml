function ObjFloatingPlatformScript()
{	
	// Check if platform has any movement pattern
	if MovementType != "None"
	{
		// Update rotation angle
		Angle += Speed;
	
		// Update code position
		switch MovementType
		{
			case "Horizontal":
			{
				var PosX = OriginX + dcos(Angle) * Distance;
				var PosY = OriginY;
			}
			break;
			case "Vertical":
			{
				var PosX = OriginX;
				var PosY = OriginY + dsin(Angle) * Distance;
			}
			break;
			case "Diagonal":
			{
				var xDir = Speed ? 1 : -1;
				var PosX = OriginX + dsin(Angle) * Distance * xDir;
				var PosY = OriginY + dsin(Angle) * Distance;
			}
			break;
			case "Circular":
			{
				var PosX = OriginX + dcos(Angle) * Distance;
				var PosY = OriginY + dsin(Angle) * Distance;
			}
			break;
		}
	
		// Limit angle value
		Angle = Angle mod 360;
	}
	else
	{
		var PosX = OriginX;
		var PosY = OriginY;
	}
	
	// Lower the platform if player is standing on it
	if Player.OnObject == id
	{
		Weight += 0.25;
		
		// TODO: Finish this
		if DoFall
		{
			if FallState = false
			{
				FallTimer++
				if FallTimer == 32
				{	
					FallState = true;
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
	
	// Update physical position
	x = floor(PosX);
	y = floor(PosY + Weight);
	
	// Do collision
	object_act_solid(false, true, false);
}