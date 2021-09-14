function ObjFloatingPlatformMain()
{	
	switch State
	{
		// Movement / Idle
		case 0:
		{
			if Player.OnObject == id
			{
				// Fall after 30 frames if flag is set
				if DoFall
				{
					if (++Timer) == 30
					{
						State++;
						Timer = 32;
				
						// Do not unload automatically
						object_set_unload(false);
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
			
			var PosX = OriginX;
			var PosY = OriginY;
	
			// Check if platform has movement pattern assigned
			if MovementType != "None"
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
		break;
		
		// Fall
		case 1:
		{
			FallSpeed += 0.21875;
			OriginY   += FallSpeed;
		
			// Make player lose the platform after 32 frames
			if !(--Timer) and Player.OnObject == id
			{
				Player.OnObject = false;
			}
		
			// Delete platform
			if OriginY > Stage.BottomBoundary
			{
				instance_destroy();
			}
		}
		break;
	}
}