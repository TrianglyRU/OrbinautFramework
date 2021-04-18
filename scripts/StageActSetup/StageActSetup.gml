function StageActSetup()
{	
	// Setup stage properties
	switch room 
	{	
		// Undentified Zone
		default:
		{
			CardName				= "UNDENFITIED ZONE";	
			ZoneID					= 0;
			ActID					= 0;
			ZoneActAmount		    = 2;
			CardEnabled				= true;
			TimeEnabled				= false;
			Time					= 0;
			WaterLevel				= room_height;
			LeftBoundary			= 0;
			TopBoundary				= 0;
			RightBoundary			= room_width;
			BottomBoundary			= room_height;
			State					= ActStateLoading;
			
			StageMusic				= noone;
			StageMusicDAC			= noone;
			LoopStart				= 0;
			LoopEnd					= 0;
		}
		break;
		
		// Gemstone Valley Zone
		case GVZ:
		{
			CardName				= "GEMSTONE VALLEY";	
			ZoneID					= 0;
			ActID					= 0;
			ZoneActAmount		    = 2;
			CardEnabled				= true;
			TimeEnabled				= false;
			Time					= 0;
			WaterLevel				= room_height;
			LeftBoundary			= 0;
			TopBoundary				= 0;
			RightBoundary			= 3488;
			BottomBoundary			= 800;
			State					= ActStateLoading;
			
			StageMusic				= GemstoneValley;
			StageMusicDAC			= noone;
			LoopStart				= 0;
			LoopEnd					= 277.01;
		}
		break;
	}	
}