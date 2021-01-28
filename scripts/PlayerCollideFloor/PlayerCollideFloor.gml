function PlayerCollideFloor()
{	
	// Get distances and floor angle
	switch round(Angle/90) % 4
	{
		case ModeFloor:
		{	
			// Set coordinates
			var xLeft  = floor(PosX - xRadius);
			var yLeft  = floor(PosY + yRadius);
			var xRight = floor(PosX + xRadius);
			var yRight = floor(PosY + yRadius);
			
			// Get floor distances
			var dLeft  = colmask_get_distance_v(xLeft, yLeft, true, TileSize)
			var dRight = colmask_get_distance_v(xRight, yRight, true, TileSize)
			
			// Get floor angle
			var Ang = dLeft <= dRight? colmask_get_angle_v(xLeft, yLeft, true) : colmask_get_angle_v(xRight, yRight, true);
		}
		break;
		case ModeWallR:
		{	
			// Set coordinates
			var xLeft  = floor(PosX + yRadius);
			var yLeft  = floor(PosY + xRadius);
			var xRight = floor(PosX + yRadius);
			var yRight = floor(PosY - xRadius);
			
			// Get floor distances
			var dLeft  = colmask_get_distance_h(xLeft, yLeft, true, TileSize)
			var dRight = colmask_get_distance_h(xRight, yRight, true, TileSize)
			
			// Get floor angle
			var Ang = dLeft <= dRight? colmask_get_angle_h(xLeft, yLeft, true) : colmask_get_angle_h(xRight, yRight, true);
		}
		break;
		case ModeRoof:
		{	
			// Set coordinates
			var xLeft  = floor(PosX + xRadius);
			var yLeft  = floor(PosY - yRadius);
			var xRight = floor(PosX - xRadius);
			var yRight = floor(PosY - yRadius);
			
			// Get floor distances and angles
			var dLeft  = colmask_get_distance_v(xLeft, yLeft, false, TileSize)
			var dRight = colmask_get_distance_v(xRight, yRight, false, TileSize)
			
			// Get floor angle
			var Ang = dLeft <= dRight? colmask_get_angle_v(xLeft, yLeft, false) : colmask_get_angle_v(xRight, yRight, false);		
		}
		break;
		case ModeWallL:
		{	
			// Set coordinates
			var xLeft  = floor(PosX - yRadius);
			var yLeft  = floor(PosY - xRadius);
			var xRight = floor(PosX - yRadius);
			var yRight = floor(PosY + xRadius);
			
			// Get floor distances and angles
			var dLeft  = colmask_get_distance_h(xLeft, yLeft, false, TileSize)
			var dRight = colmask_get_distance_h(xRight, yRight, false, TileSize)
			
			// Get floor angle
			var Ang = dLeft <= dRight? colmask_get_angle_h(xLeft, yLeft, false) : colmask_get_angle_h(xRight, yRight, false);
		}
		break;
	}
	
	// Update player's angle
	if Game.ConsiderAngleDifference
	{	
		var Difference = abs(Angle - Ang);
		if  Difference < 180
		{	
			Angle = Difference > 45 ? (round(Angle/90) % 4) * 90 : Ang;
		}
		else
		{	
			Angle = Difference < 315 ? (round(Angle/90) % 4) * 90 : Ang;
		}	
	}
	else
	{	
		Angle = Ang;
	}
	
	// Calculate collision tollerance
	if (round(Angle/90) % 4) mod 2 = 0
	{
		CollisionDistance = Game.SpeedFloorClip ? min(4 + abs(floor(Xsp)), 14) : 14;
	}
	else
	{
		CollisionDistance = Game.SpeedFloorClip ? min(4 + abs(floor(Ysp)), 14) : 14;
	}
	
	// Collide using shortest distance
	var Distance = dLeft <= dRight ? dLeft : dRight;
	if  Distance > CollisionDistance
	{
		Grounded = false;
	}
	else switch round(Angle/90) % 4
	{
		case ModeFloor: PosY += Distance; break;
		case ModeWallR: PosX += Distance; break;
		case ModeRoof:  PosY -= Distance; break;
		case ModeWallL: PosX -= Distance; break;
	}
}