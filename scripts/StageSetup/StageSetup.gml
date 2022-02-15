function StageSetup()
{	
	/* Assign ZoneID (starting from 0) for your stages in the
	order they're gonna be played. It is used for save files */
	
	/* Set here the ID of your last zone. It will be 
	used to mark the save file as the complete one */
	FinalZoneID = 99;
	
	switch room 
	{	
		/* When you start adding your stages, make sure to remove this stage
		from this list or set its ZoneID to a high value (like 98)*/
		case Stage_TVZ:
		{
			ZoneName         = "WIREFRAME VALLEY";
			ZoneID           = 0;
			ActID            = 0;
			IsLastZoneAct    = true;
			WaterEnabled     = true;
			WaterLevel       = 976 //1384;
			StageMusic       = TestValley;
			LeftBoundary     = 0;
			TopBoundary      = 0;
			RightBoundary    = room_width;
			BottomBoundary   = 1016;
			AnimatedGraphics = [tex_tvz_anitile00, 24];
			AnimalSet        = [spr_obj_animal_flicky, spr_obj_animal_ricky];
			NextStage		 = Screen_DevMenu;
		}
		break;
		default:
		{
			ZoneName	     = "UNKNOWN";
			ZoneID		     = 0;
			ActID		     = 0;
			IsLastZoneAct    = true;
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
