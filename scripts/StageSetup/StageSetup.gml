function StageSetup()
{	
	/* Set here the ID of your last zone. It will be 
	used to mark the savefile as the complete one */
	FinalZoneID = 3;
	
	// Osillate angle value. Do not edit unless really needed!
	OscillateAngle = 1.40625;
	
	switch room 
	{	
		// Make sure to change the zone ID!
		case Stage_TZ:
		{
			ZoneName         = "GREEN HILL";
			ZoneID           = 0;
			ActID            = 0;
			FinalActID       = 0;
			WaterEnabled     = true;
			WaterLevel       = 1384;
			StageMusic       = TestStage;
			LeftBoundary     = 0;
			TopBoundary      = 0;
			RightBoundary    = room_width;
			BottomBoundary   = 1016;
			AnimatedGraphics = [tex_tsz_anitile00, 24];
			AnimalSet        = [spr_obj_animal_flicky, spr_obj_animal_ricky];
			NextStage		 = Screen_DevMenu;
		}
		break;
		default:
		{
			ZoneName	     = "UNKNOWN";
			ZoneID		     = 0;
			ActID		     = 0;
			FinalActID       = 0;
			WaterEnabled     = false;
			WaterLevel	     = 0;
			StageMusic       = noone;
			LeftBoundary	 = 0;
			TopBoundary	     = 0;
			RightBoundary	 = room_width;
			BottomBoundary	 = room_height;
			AnimatedGraphics = noone;		// Array: [sprite1, sprite1_duration, sprite2, sprite2_duration...]	
			AnimalSet	     = noone;		// Array: [animal_sprite1, animal_sprite2...]
			NextStage		 = Screen_DevMenu;
		}
		break;
	}
}
