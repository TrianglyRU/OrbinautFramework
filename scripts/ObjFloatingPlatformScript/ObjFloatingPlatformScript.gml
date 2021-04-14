function ObjFloatingPlatformScript()
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
	
	// Update physical position
	x = floor(PosX);
	y = floor(PosY);
	
	// Do collision
	object_do_collision(SolidTop, false);

}