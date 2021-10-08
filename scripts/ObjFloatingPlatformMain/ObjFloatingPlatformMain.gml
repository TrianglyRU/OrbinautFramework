function ObjFloatingPlatformMain()
{	
	switch State
	{
		// Movement / Idle
		case 0:
		{
			var PosX = OriginX;
			var PosY = OriginY;
			
			if Player.OnObject == id
			{
				// Fall after 30 frames if flag is set
				if DoFall
				{
					if (++Timer) == 30
					{
						State  += 1;
						Timer   = 32;
						OriginY = OriginY + Weight;
				
						// Delete the object once it goes off-screen
						object_set_unload(TypeDelete);
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
			
			// Update position
			y = floor(OriginY);
		
			// Make player lose the platform after 32 frames
			if !(--Timer) and Player.OnObject == id
			{
				Player.OnObject = false;
			}
			else
			{
				// Do collision
				object_act_solid(false, true, false, false);
			}
		}
		break;
	}
}