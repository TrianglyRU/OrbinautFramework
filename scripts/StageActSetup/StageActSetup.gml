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
			BottomBoundary			= 848;
			State					= ActStateLoading;
			
			StageMusic				= GemstoneValley;
			StageMusicDAC			= noone;
			LoopStart				= 0;
			LoopEnd					= 138.17;
		}
		break;
		
		// Moonlight Base
		case MBZ:
		{
			CardName				= "MOONLIGHT BASE";	
			ZoneID					= 1;
			ActID					= 0;
			ZoneActAmount		    = 2;
			CardEnabled				= true;
			TimeEnabled				= false;
			Time					= 0;
			WaterLevel				= 800;
			LeftBoundary			= 0;
			TopBoundary				= 0;
			RightBoundary			= room_width;
			BottomBoundary			= room_height;
			State					= ActStateLoading;
			
			StageMusic				= TechnoPower;
			StageMusicDAC			= noone;
			LoopStart				= 0;
			LoopEnd					= 335.01;
		}
		break;	
		
		// Horizon Heights
		case HHZ:
		{
			CardName				= "HORIZON HEIGHTS";											
			ZoneID					= 1;							
			ActID					= 0;
			ZoneActAmount		    = 1;
			CardEnabled				= true;							
			TimeEnabled				= false;						
			Time					= 0;							
			WaterLevel				= 2592;							
			LeftBoundary			= 0;							
			TopBoundary				= 0;							
			RightBoundary			= room_width;					
			BottomBoundary			= room_height;					
			State					= ActStateLoading;
			
			StageMusic				= HorizonHeights;				
			StageMusicDAC			= noone;						
			LoopStart				= 0;						
			LoopEnd					= 167.163;
		}
		break;	
	}	
}