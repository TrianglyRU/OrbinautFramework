function PlayerHitWalls()
{		
	/* Wall collision is performed a frame ahead when grounded, so we add Xsp and Ysp to sensor position. 
	We also offset the position down 8 pixels on flat floor to keep us from clipping up small steps */	
	var SpdX = Grounded * Xsp;
	var SpdY = Grounded * Ysp;
	var Ofst = (Grounded and !Angle) * 8; 
	
	// Left wall
	if sensor_active(Sensor[WallL])
	{	
		// Update position
		switch CollisionMode
		{
			case ModeFloor: 
				Sensor[WallL][xPos] = floor(PosX + SpdX - 10);
				Sensor[WallL][yPos] = floor(PosY + SpdY + Ofst);
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
		
		// Get distance
		if !Game.TileCollisionMethod
		{
			Sensor[WallL][Dist] = colmask_get_distance(Sensor[WallL]);
		}
		else
		{
			Sensor[WallL][Dist] = tile_get_distance(Sensor[WallL]);
		}

		// Collide if the distance is negative
		if Sensor[WallL][Dist] < 0
		{	
			if Grounded 
			{
				switch CollisionMode 
				{
					case ModeFloor: 
						Xsp -= Sensor[WallL][Dist]; 
					break;
					case ModeWallR: 
						Ysp += Sensor[WallL][Dist]; 
					break;
					case ModeRoof:  
						Xsp += Sensor[WallL][Dist]; 
					break;
					case ModeWallL: 
						Ysp -= Sensor[WallL][Dist]; 
					break;
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
	
	// Right wall
	if sensor_active(Sensor[WallR])
	{	
		// Update position
		switch CollisionMode
		{
			case ModeFloor: 
				Sensor[WallR][xPos] = floor(PosX + SpdX + 10);
				Sensor[WallR][yPos] = floor(PosY + SpdY + Ofst);
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
			break;
		}
		
		// Get distance
		if !Game.TileCollisionMethod
		{
			Sensor[WallR][Dist] = colmask_get_distance(Sensor[WallR]);
		}
		else
		{
			Sensor[WallR][Dist] = tile_get_distance(Sensor[WallR]);
		}
		
		// Collide if the distance is negative
		if Sensor[WallR][Dist] < 0
		{
			if Grounded 
			{
				switch CollisionMode 
				{
					case ModeFloor:
						Xsp += Sensor[WallR][Dist]; 
					break;
					case ModeWallR:
						Ysp -= Sensor[WallR][Dist]; 
					break;
					case ModeRoof: 
						Xsp -= Sensor[WallR][Dist]; 
					break;
					case ModeWallL: 
						Ysp += Sensor[WallR][Dist]; 
					break;
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