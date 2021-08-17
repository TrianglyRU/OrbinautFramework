function StageSetup()
{	
	switch room 
	{	
		// Moonlight Quadrant 1
		case MQZ0:
		{
			ZoneName		 = "MOONLIGHT QUADRANT";
			ZoneID			 = 0;
			ActID			 = 0;
			FinalActID		 = 1;
			CardEnabled		 = true;
			TimeEnabled		 = false;
			WaterEnabled     = true;
			WaterLevel		 = 2240;
			StageMusic		 = StarryNight;
			LeftBoundary	 = 0;
			TopBoundary		 = 768;
			RightBoundary	 = room_width;
			BottomBoundary   = room_height;
			AnimatedGraphics = [tex_mqz_anitile, 6];
			AnimalSet		 = [spr_obj_animal_flicky, spr_obj_animal_pocky, spr_obj_animal_cucky, spr_obj_animal_pecky, spr_obj_animal_picky, spr_obj_animal_ricky, spr_obj_animal_rocky];
		}
		break;
		
		// Default
		default:
		{
			ZoneName			= "UNKNOWN LEVEL";
			ZoneID				= -1;
			ActID				= 0;
			FinalActID			= 1;			
			CardEnabled			= true;
			TimeEnabled			= false;
			WaterEnabled        = false;
			WaterLevel			= 0;
			StageMusic			= noone;
			LeftBoundary		= 0;
			TopBoundary			= 0;
			RightBoundary		= room_width;
			BottomBoundary		= room_height;
			AnimatedGraphics	= noone;
			AnimalSet			= noone;
		}
		break;
	}
}