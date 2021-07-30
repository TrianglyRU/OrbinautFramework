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
			TopBoundary				= 768;
			RightBoundary			= room_width;
			BottomBoundary			= room_height//1680;
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