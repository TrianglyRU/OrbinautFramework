function ObjFloatingPlatformMain()
{	
	switch State
	{
		case 0:
		{
			var PosX = OriginX;
			var PosY = OriginY;
			
			if object_check_touch(TypeSolidU)
			{
				if DoFall == 1
				{
					// Increment flag
					DoFall = 2;
				}
				
				// Lower the platform
				Weight += 0.25;
			}
			else
			{
				Weight -= 0.25;
			}
			Weight = clamp(Weight, 0, 4);
			
			// Fall after 30 frames if flag is set
			if DoFall == 2
			{
				if (++Timer) == 30
				{
					State  += 1;
					Timer   = 32;
					OriginY = OriginY + Weight;
					
					object_set_unload(TypeDelete);
				}
			}
			
			// Move the platform according to its movement type
			if MovementType != "None"
			{
				var Angle = (abs(Speed * Stage.OscillateAngle) * Stage.Time) mod 360;

				switch MovementType
				{
					case "Horizontal":
					{
						PosX += dcos(Angle + 90) * Distance * (InverseX ? -1 : 1);
					}
					break;
					case "Vertical":
					{
						PosY += dsin(Angle) * Distance * (InverseY ? -1 : 1);
					}
					break;
					case "Diagonal":
					{
						PosX += dsin(Angle + InverseX * 180) * Distance;
						PosY += dsin(Angle + InverseY * 180) * Distance;
					}
					break;
					case "Circular":
					{
						PosX += dcos(Angle) * Distance * (InverseX ? -1 : 1);
						PosY += dsin(Angle) * Distance * (InverseY ? -1 : 1);
					}
					break;
				}
			}
	
			x = floor(PosX);
			y = floor(PosY + Weight);
	
			// Do collision
			object_act_solid(false, true, false, false);
		}
		break;
		case 1:
		{
			FallSpeed += 0.21875;
			OriginY   += FallSpeed;

			y = floor(OriginY);
		
			// Make player lose the platform after 32 frames
			if !(--Timer) and object_check_touch(TypeSolidU)
			{
				Player.PosY	   += FallSpeed;
				Player.OnObject = false;
				Player.Grounded = false;
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