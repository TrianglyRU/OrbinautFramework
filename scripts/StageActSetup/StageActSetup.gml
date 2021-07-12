function StageActSetup()
{	
	// Setup stage properties
	switch room 
	{	
		case MQZ0:
		{
			ZoneName			    = "MOONLIGHT QUADRANT";
			ZoneID					= 0;
			ActID					= 0;
			FinalActID			    = 1;
			
			CardEnabled				= true;
			TimeEnabled				= false;
			
			WaterEnabled            = true;
			WaterLevel				= 2240;

			StageMusic				= StarryNight;
			StageMusicLooppoint		= 0;
			
			LeftBoundary			= 0;
			TopBoundary				= 0;
			RightBoundary			= room_width;
			BottomBoundary			= room_height;
		}
		break;
		
		// Moonlight Quadrant 1
		case MQZ1:
		{
			ZoneName			    = "MOONLIGHT QUADRANT";		
			ZoneID					= 0;
			ActID					= 1;
			FinalActID			    = 2;
			
			CardEnabled				= true;
			TimeEnabled				= false;
			
			WaterEnabled            = true;
			WaterLevel				= 1568;

			StageMusic				= StarryNight;
			StageMusicLooppoint		= 0;
			
			LeftBoundary			= 0;
			TopBoundary				= 0;
			RightBoundary			= room_width;
			//BottomBoundary	    = 1728;
			BottomBoundary			= room_height;
		}
		break;
		
		// Moonlight Quadrant 1
		case MQZ2:
		{
			ZoneName			    = "MOONLIGHT QUADRANT";
			ZoneID					= 0;
			ActID					= 2;
			FinalActID			    = 2;
			
			CardEnabled				= true;
			TimeEnabled				= false;
			
			WaterEnabled            = false;
			WaterLevel				= 0;

			StageMusic				= MoonlightQuadrant;
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
			StageMusicLooppoint		= 0;
			
			LeftBoundary			= 0;
			TopBoundary				= 0;
			RightBoundary			= room_width;
			BottomBoundary			= room_height;
		}
		break;
	}	
}