function StageSetup()
{	
	switch room 
	{	
		// Default
		default:
		{
			ZoneName			= "TEST STAGE";
			ZoneID				= -1;
			ActID				= 0;
			FinalActID			= 0;
			CardEnabled			= false;
			WaterEnabled        = true;
			WaterLevel			= 640;
			StageMusic			= TestStageMusic;
			LeftBoundary		= 0;
			TopBoundary			= 0;
			RightBoundary		= room_width;
			BottomBoundary		= room_height;
			AnimatedGraphics	= noone;		// Array: [sprite1, sprite1_duration, sprite2, sprite2_duration...]	
			AnimalSet			= [spr_obj_animal_ricky];		// Array: [animal_sprite1, animal_sprite2...]
		}
		break;
	}
}