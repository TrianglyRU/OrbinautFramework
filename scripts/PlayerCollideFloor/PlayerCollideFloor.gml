function PlayerCollideFloor()
{	
	if sensor_active(Sensor[FloorL]) and sensor_active(Sensor[FloorR])
	{
		// Use a sensor with a shortest distance
		var Used = Sensor[FloorL][Dist] <= Sensor[FloorR][Dist] ? FloorL : FloorR;
		
		// Calculate collision tolerance
		if !Game.SpeedFloorClip 
		{
			CollisionDistance = 14;
		} 
		else 
		{
			CollisionDistance = min(4 + abs(floor(CollisionMode mod 2 = 0 ? Xsp : Ysp)), 14);
		}
		
		// Go airborne if the distance is greater than collision tolerance
		if Sensor[Used][Dist] > CollisionDistance
		{
			Grounded = false;
		}
		
		// Else adhere to the floor
		else
		{
			switch CollisionMode 
			{	
				case ModeFloor:	PosY += Sensor[Used][Dist]; break;
				case ModeWallR: PosX += Sensor[Used][Dist]; break;
				case ModeRoof:  PosY -= Sensor[Used][Dist]; break;
				case ModeWallL: PosX -= Sensor[Used][Dist]; break;
			}
		}
	}
}