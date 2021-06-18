function ObjFloatingPlatformScript()
{
	if keyboard_check_pressed(ord("H"))
	{
		instance_destroy();
	}
	
	// Check if platform has any movement pattern
	if PlatformMovement != "None"
	{
		// Update rotation angle
		Angle += PlatformSpeed;
	
		// Update code position
		switch PlatformMovement
		{
			case "Horizontal":
			{
				var PosX = OriginX + dcos(Angle) * PlatformDistance;
				var PosY = OriginY;
			}
			break;
			case "Vertical":
			{
				var PosX = OriginX;
				var PosY = OriginY + dsin(Angle) * PlatformDistance;
			}
			break;
			case "Diagonal":
			{
				var xDir = PlatformSpeed ? 1 : -1;
				var PosX = OriginX + dsin(Angle) * PlatformDistance * xDir;
				var PosY = OriginY + dsin(Angle) * PlatformDistance;
			}
			break;
			case "Circular":
			{
				var PosX = OriginX + dcos(Angle) * PlatformDistance;
				var PosY = OriginY + dsin(Angle) * PlatformDistance;
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
		if PlatformDoFall
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
	object_act_solid(false, true, false, false);
}