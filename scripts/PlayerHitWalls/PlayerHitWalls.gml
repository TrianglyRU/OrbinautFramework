function PlayerHitWalls()
{		
	// Adjust sensors position by adding player's speed to them
	var SpdX = Grounded * Xsp;
	var SpdY = Grounded * Ysp;
	var Ofst = Grounded and Angle == 0;
	
	// Left wall collision
	if sensor_active(Sensor[WallL])
	{	
		// Update sensor position and find the distance
		switch CollisionMode 
		{
			case ModeFloor:
				Sensor[WallL][xPos] = floor(PosX + SpdX - 10);
				Sensor[WallL][yPos] = floor(PosY + SpdY + Ofst * 8);	
			break;
			case ModeWallR:
				Sensor[WallL][xPos] = floor(PosX + SpdX);
				Sensor[WallL][yPos] = floor(PosY + SpdY + 10);
			break;
			case ModeRoof:
				Sensor[WallL][xPos] = floor(PosX + SpdX + 10);
				Sensor[WallL][yPos] = floor(PosY + SpdY);
			break;
			case ModeWallL:
				Sensor[WallL][xPos] = floor(PosX + SpdX);
				Sensor[WallL][yPos] = floor(PosY + SpdY - 10);
			break;
		}
		if !Game.TileCollisionMethod
		{
			Sensor[WallL][Dist] = colmask_get_distance(Sensor[WallL]);
		}
		else
		{
			Sensor[WallL][Dist] = tile_get_distance(Sensor[WallL]);
		}

		// Collide when the distance is negative
		if Sensor[WallL][Dist] < 0
		{	
			if Grounded 
			{
				switch CollisionMode 
				{
					case ModeFloor: Xsp -= Sensor[WallL][Dist]; break;
					case ModeWallR: Ysp += Sensor[WallL][Dist]; break;
					case ModeRoof:  Xsp += Sensor[WallL][Dist]; break;
					case ModeWallL: Ysp -= Sensor[WallL][Dist];	break;
				}
			}
			else 
			{
				PosX -= Sensor[WallL][Dist];
				Xsp   = 0;
			}
			Inertia = 0;
		}
	}
	
	// Right wall collision
	if sensor_active(Sensor[WallR])
	{
		// Update sensor position and find the distance
		switch CollisionMode 
		{
			case ModeFloor:
				Sensor[WallR][xPos] = floor(PosX + SpdX + 10);
				Sensor[WallR][yPos] = floor(PosY + SpdY + Ofst * 8);
			break;
			case ModeWallR:
				Sensor[WallR][xPos] = floor(PosX + SpdX);
				Sensor[WallR][yPos] = floor(PosY + SpdY - 10);
			break;
			case ModeRoof:
				Sensor[WallR][xPos] = floor(PosX + SpdX - 10);
				Sensor[WallR][yPos] = floor(PosY + SpdY);
			break;
			case ModeWallL:
				Sensor[WallR][xPos]	= floor(PosX + SpdX);
				Sensor[WallR][yPos] = floor(PosY + SpdY + 10);
			break
		}
		if !Game.TileCollisionMethod
		{
			Sensor[WallR][Dist] = colmask_get_distance(Sensor[WallR]);
		}
		else
		{
			Sensor[WallR][Dist] = tile_get_distance(Sensor[WallR]);
		}
		
		// Collide when the distance is negative
		if Sensor[WallR][Dist] < 0
		{
			if Grounded 
			{
				switch CollisionMode 
				{
					case ModeFloor: Xsp += Sensor[WallR][Dist]; break;
					case ModeWallR: Ysp -= Sensor[WallR][Dist]; break;
					case ModeRoof:  Xsp -= Sensor[WallR][Dist]; break;
					case ModeWallL: Ysp += Sensor[WallR][Dist]; break;
				}
			} 
			else 
			{
				PosX += Sensor[WallR][Dist];
				Xsp   = 0;
			}
			Inertia = 0;
		}
	}
}