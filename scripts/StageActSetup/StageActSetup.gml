function StageActSetup()
{	
	// Setup stage properties
	switch room 
	{	
		// Gemstone Valley 1
		case GVZ:
		{
			CardNameTop				= "GEMSTONE";	
			CardNameBottom			= "VALLEY";	
			ZoneID					= 0;
			ActID					= 0;
			FinalActID			    = 1;
			CardEnabled				= true;
			TimeEnabled				= false;
			Time					= 0;
			WaterLevel				= 2480;
			LeftBoundary			= 0;
			TopBoundary				= 0;
			RightBoundary			= 10000;
			BottomBoundary			= 2288;
			State					= ActStateLoading;
			StageMusic				= GemstoneValley;
			StageMusicDAC			= noone;
			LoopStart				= 0;
			LoopEnd					= 277.01;
		}
		break;
		
		// Gemstone Valley 2
		case GVZ2:
		{
			CardNameTop				= "GEMSTONE";	
			CardNameBottom			= "VALLEY";	
			ZoneID					= 0;
			ActID					= 1;
			FinalActID				= 1;
			CardEnabled				= true;
			TimeEnabled				= false;
			Time					= 0;
			WaterLevel				= room_height;
			LeftBoundary			= 0;
			TopBoundary				= 0;
			RightBoundary			= 1536;
			BottomBoundary			= 2430;
			State					= ActStateLoading;
			StageMusic				= GemstoneValley;
			StageMusicDAC			= noone;
			LoopStart				= 0;
			LoopEnd					= 277.01;
		}
		break;
		
		
		// Undentified Zone
		default:
		{
			CardNameTop				= "UNDENFITIED";	
			CardNameBottom			= "";
			ZoneID					= -1;
			ActID					= 0;
			FinalActID				= 1;
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
	}	
}