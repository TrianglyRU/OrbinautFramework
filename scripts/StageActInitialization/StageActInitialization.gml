function StageActInitialization()
{	
	// Disable collision showcase
	//StageCollision.visible = true;
	
	switch room 
	{
		// Moonlight Base
		case MBZ:
			CardName				= "MOONLIGHT BASE";	
			TimeEnabled				= false;	
			CardEnabled				= true;	
			ZoneID					= 10; 
			ActID					= 0;	
			WaterLevel				= 0;	
			Time					= 0;
			LeftBoundary			= 0;
			TopBoundary				= 0;
			RightBoundary			= room_width;
			BottomBoundary			= room_height;
			LastCheckpoint			= Game.SavedCheckpoint;	
			State					= StateDefault;
		break;	
	}	
}