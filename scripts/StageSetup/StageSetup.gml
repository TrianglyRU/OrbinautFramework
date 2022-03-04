function StageSetup()
{	
	/* Please note, that SaveProgress should be set to true only if the current stage
	is the last Act of the current Zone AND should save the progress once it is beaten
	
	IsFinalStage should only be used for the stage beating which  
	should mark the game in current saveslot as completed */
	
	switch room 
	{	
		// Wireframe Valley
		case Stage_TVZ:
		{
			ZoneName         = "  MOONLIGHT QUADRANT";
			ActID            = 0;
			WaterLevel       = 1384;
			WaterEnabled     = true;
			StageMusic       = TestValley;
			AnimatedGraphics = [tex_tsz_anitile, 6];
			AnimalSet        = [spr_obj_animal_flicky, spr_obj_animal_ricky];
			BottomBoundary   = room_height;
			
			SaveProgress = false;
			IsFinalStage = false;
			NextStage	 = Screen_DevMenu;
		}
		break;
		
		// Template
		default:
		{
			ZoneName	     = "TEMPLATE";
			ActID		     = 0;
			WaterLevel	     = 0;
			WaterEnabled     = false;
			StageMusic       = noone;
			AnimatedGraphics = noone;		// Array: [sprite1, sprite1_duration, sprite2, sprite2_duration...]	
			AnimalSet	     = noone;		// Array: [animal_sprite1, animal_sprite2...]
			BottomBoundary	 = room_height;
			
			SaveProgress = false;
			IsFinalStage = false;
			NextStage	 = Screen_DevMenu;
		}
	}
}
