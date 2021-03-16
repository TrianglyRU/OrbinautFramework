function StageActSetup()
{	
	// Setup stage properties
	switch room 
	{
		// Moonlight Base
		case MBZ:
			CardName				= "MOONLIGHT BASE";
			BackgroundMusic			= MoonlightBase;
			BackgroundDAC			= noone;
			LoopStart				= 69.490;
			LoopEnd					= 125.120;	
			ZoneID					= 0;
			ActID					= 0;
			CardEnabled				= true;
			TimeEnabled				= false;
			Time					= 0;
			WaterLevel				= 400;
			LeftBoundary			= 0;
			TopBoundary				= 0;
			RightBoundary			= room_width;
			BottomBoundary			= room_height;
			State					= ActStateLoading;
		break;	
		
		// Moonlight Base 2
		case MBZ2:
			CardName				= "MOONLIGHT BASE";				
			BackgroundMusic			= MoonlightBase;				
			BackgroundDAC			= noone;						
			LoopStart				= 69.490;						
			LoopEnd					= 125.120;							
			ZoneID					= 0;							
			ActID					= 1;							
			CardEnabled				= true;							
			TimeEnabled				= false;						
			Time					= 0;							
			WaterLevel				= 0;							
			LeftBoundary			= 0;							
			TopBoundary				= 0;							
			RightBoundary			= room_width;					
			BottomBoundary			= room_height;					
			State					= ActStateLoading;
		break;	
		
		// Horizon Heights
		case HHZ:
			CardName				= "HORIZON HEIGHTS";				
			BackgroundMusic			= HorizonHeights;				
			BackgroundDAC			= noone;						
			LoopStart				= 0;						
			LoopEnd					= 167.163;							
			ZoneID					= 1;							
			ActID					= 0;							
			CardEnabled				= true;							
			TimeEnabled				= false;						
			Time					= 0;							
			WaterLevel				= 0;							
			LeftBoundary			= 0;							
			TopBoundary				= 0;							
			RightBoundary			= room_width;					
			BottomBoundary			= room_height;					
			State					= ActStateLoading;
		break;	
	}	
}