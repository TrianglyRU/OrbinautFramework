function StageActSetup()
{	
	// Setup stage properties
	switch room 
	{	
		// Moonlight Quadrant 1
		case MQZ1:
		{
			ZoneName			    = "MOONLIGHT QUADRANT";		
			ZoneID					= 0;
			ActID					= 0;
			FinalActID			    = 1;
			
			CardEnabled				= true;
			TimeEnabled				= false;
			
			WaterEnabled            = false;
			WaterLevel				= 0;

			StageMusic				= MoonlightQuadrant;
			StageMusicDAC			= noone;
			StageMusicLooppoint		= 0;
			
			LeftBoundary			= 0;
			TopBoundary				= 0;
			RightBoundary			= room_width;
			BottomBoundary			= 1728;
		}
		break;
		
		// Moonlight Quadrant 1
		case MQZ2:
		{
			ZoneName			    = "MOONLIGHT QUADRANT";
			ZoneID					= 0;
			ActID					= 1;
			FinalActID			    = 1;
			
			CardEnabled				= true;
			TimeEnabled				= false;
			
			WaterEnabled            = false;
			WaterLevel				= 0;

			StageMusic				= MoonlightQuadrant;
			StageMusicDAC			= noone;
			StageMusicLooppoint		= 0;
			
			LeftBoundary			= 0;
			TopBoundary				= 0;
			RightBoundary			= 1024;
			BottomBoundary			= 1120;
		}
		break;
		
		// Undentified Zone
		default:
		{
			ZoneName			    = "UNKNOWN LEVEL";
			ZoneID					= -1;
			ActID					= 0;
			FinalActID			    = 1;
			
			CardEnabled				= true;
			TimeEnabled				= false;
			
			WaterEnabled            = false;
			WaterLevel				= 0;

			StageMusic				= noone;
			StageMusicDAC			= noone;
			StageMusicLooppoint		= 0;
			
			LeftBoundary			= 0;
			TopBoundary				= 0;
			RightBoundary			= room_width;
			BottomBoundary			= room_height;
		}
		break;
	}	
}