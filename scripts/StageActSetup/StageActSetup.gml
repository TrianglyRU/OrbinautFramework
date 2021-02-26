function StageActSetup()
{	
	switch room 
	{
		// Moonlight Base
		case MBZ:
			CardName				= "MOONLIGHT BASE";				// Level name
			BackgroundMusic			= MoonlightBase;				// Background music
			BackgroundDAC			= noone;						// DAC channel of bgm
			LoopStart				= 69.490;						// Music loop start point
			LoopEnd					= 125.120;						// Music loop end point			
			ZoneID					= 10;							// Zone ID, used for saving
			ActID					= 0;							// Act ID, used for displaying act number and saving
			CardEnabled				= true;							// Enable title card, else just fade in
			TimeEnabled				= false;						// Enable time counter right from the start
			Time					= 0;							// Default stage time upon loading
			WaterLevel				= 0;							// Water level (y position)
			LeftBoundary			= 0;							// Left stage limit
			TopBoundary				= 0;							// Top stage limit
			RightBoundary			= room_width;					// Right stage limit
			BottomBoundary			= room_height;					// Bottom stage limit
			State					= ActStateLoading;				// Stage state upon loading
		break;	
		
		// Moonlight Base 2
		case MBZ2:
			CardName				= "MOONLIGHT BASE";				
			BackgroundMusic			= MoonlightBase;				
			BackgroundDAC			= noone;						
			LoopStart				= 69.490;						
			LoopEnd					= 125.120;							
			ZoneID					= 10;							
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
			BackgroundMusic			= MoonlightBase;				
			BackgroundDAC			= noone;						
			LoopStart				= 69.490;						
			LoopEnd					= 125.120;							
			ZoneID					= 10;							
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
	}	
}