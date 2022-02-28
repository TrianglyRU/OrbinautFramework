function ObjFloatingPlatformMain()
{	
	switch State
	{
		case 0:
		{
			var PosX = OriginX;
			var PosY = OriginY;
			
			// Lower the platform
			if object_check_touch(ColSolidU)
			{
				if MovementType == "Fall"
				{
					FallFlag = true;
				}
				Weight += 0.25;
			}
			else
			{
				Weight -= 0.25;
			}
			Weight = clamp(Weight, 0, 4);
			
			// Update platform movement
			if MovementType == "Fall"
			{
				if FallFlag and (++Timer) == 30
				{
					State  += 1;
					Timer   = 31;
					OriginY = OriginY + Weight;
					
					// Platform should reset itself once it goes off-screen
					object_set_unload(FlagReset);
				}
			}
			else 
			{
				var Angle = abs(Speed * Stage.OscillateAngle) * (Stage.Time) mod 360;
				var Flip  = Inverse ? 1 : -1;
				
				switch MovementType
				{
					case "Horizontal":
						PosX += dcos(Angle + 90) * Distance * Flip;
					break;
					case "Vertical":
						PosY += dcos(Angle + 90) * Distance * Flip;
					break;
					case "Diagonal 45":
						PosX += dsin(Angle + 180) * Distance * Flip;
						PosY += dsin(Angle)		  * Distance * Flip;
					break;
					case "Diagonal 315":
						PosX -= dsin(Angle) * Distance * Flip;
						PosY -= dsin(Angle) * Distance * Flip;
					break;
					case "Circular":
						PosX += dsin(Angle) * Distance * Flip;
						PosY += dcos(Angle) * Distance * Flip;
					break;
				}
			}
			
			// Update position
			x = floor(PosX);
			y = floor(PosY + Weight);
			
			// Do collision
			object_act_solid(false, true, false, false);
		}
		break;
		case 1:
		{
			if y > Stage.BottomBoundary
			{
				State++;
			}
			
			// Move and update position
			FallSpeed += 0.21875;
			OriginY   += FallSpeed;
			y		   = floor(OriginY);
		
			// Make player lose the platform after 32 frames
			if (--Timer) == 0
			{
				if object_check_touch(ColSolidU)
				{
					Player.Ysp		= FallSpeed;
					Player.OnObject = false;
					Player.Grounded = false;
				}
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