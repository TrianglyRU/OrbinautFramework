/// @description Startup / Setup
// You can call your scripts in this editor

	#region Setup
	{
		/* Please note, that SaveProgress should be set to true only if the current stage
		is the last Act of the current Zone AND should save the progress once it is beaten
	
		IsFinalStage should only be used for the stage beating which  
		should mark the game in current saveslot as completed */
	
		switch room 
		{	
			// Wireframe Valley
			case Stage_TSZ:
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
	#endregion
	
	#region Startup
	{
		RightBoundary  =  room_width;
		LeftBoundary   =  0;
		TopBoundary	   =  0;
		RestartTimer   =  0;
		RestartEvent   =  0;
		WaterOffset	   =  0;
		IsFinished	   =  0;
		IsPaused	   =  0;
		Time		   =  0;
		TimeEnabled	   =  0;
		IsBossfight    = -1;
		OscillateAngle = -2.8125;
		UpdateObjects  =  false;
	
		// Remember current room index
		global.StageRoom = room;
	
		// Set bubble wobble data
		if WaterEnabled
		{
			WobbleData =
			[ 
			  0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2,
			  2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
			  3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2,
			  2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0,
			  0,-1,-1,-1,-1,-1,-2,-2,-2,-2,-2,-3,-3,-3,-3,-3,
			 -3,-3,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,
			 -4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-4,-3,
			 -3,-3,-3,-3,-3,-3,-2,-2,-2,-2,-2,-1,-1,-1,-1,-1
			]
		}
	
		// Load saved data if loading into the stage from Bonus or Special Stage
		if array_length(global.StarPostData)
		{
			Time		   = global.StarPostData[2];
			BottomBoundary = global.StarPostData[3];
		}
		if array_length(global.SpecialRingData)
		{
			Time		   = global.SpecialRingData[4];
			BottomBoundary = global.SpecialRingData[5];
		
			// Clear data (player has already restored their rings and barrier atm.)
			global.SpecialRingData = [];
		}
	
		// Set stage boundaries
		TargetLeftBoundary   = LeftBoundary;
		TargetRightBoundary  = RightBoundary;
		TargetTopBoundary    = TopBoundary;
		TargetBottomBoundary = BottomBoundary;
		DeathBoundary        = BottomBoundary;
	
		// Play stage music
		audio_bgm_play(AudioPrimary, StageMusic);
	}
	#endregion