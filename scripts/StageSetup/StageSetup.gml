/// @ Called in Stage Controller -> Create Event
function StageSetup()
{
	/* Please note, that SaveProgress should be set to true only if the current stage
	is the last Act of the current Zone AND should save the progress once it is beaten
	
	IsFinalStage should only be used for the stage beating which  
	should mark the game in current saveslot as completed */
	
	switch room 
	{	
		// Twilight Station (Test Stage)
		case Stage_TSZ:
		{
			ZoneName         = "TWILIGHT____STATION";
			ActID            = 0;
			WaterLevel       = 1440;
			WaterEnabled     = true;
			StageMusic       = TestStage;
			AnimatedGraphics = [tex_tsz_anitile, 6];
			AnimalSet        = [spr_obj_animal_flicky, spr_obj_animal_ricky];
			BottomBoundary   = 1040;
			
			NextStage	 = Screen_DevMenu;
			SaveProgress = false;
			IsFinalStage = false;	
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
			AnimatedGraphics = noone;		// Array: [sprite1, sprite1 duration, sprite2, sprite2 duration...]	
			AnimalSet	     = noone;		// Array: [animalsprite1, animalsprite2...]
			BottomBoundary	 = room_height;
			
			NextStage	 = Screen_DevMenu;
			SaveProgress = false;
			IsFinalStage = false;				
		}
	}
}