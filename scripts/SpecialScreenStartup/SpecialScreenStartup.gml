function SpecialScreenStartup()
{
	// Set blank values
	State       = 0;
	RoomTimer   = 0;
	RenderFlag  = 0;
	RenderAlpha = 0;
	
	// Turn screen into white if not coming back from special stage
	if !Game.SpecialState
	{
		fade_perform(FadeTo, ColourWhite, 0);
	}
	
	// If coming back from special stage, set offsets and play music
	if Game.SpecialState
	{
		Offset[0]  = -330;
		Offset[1]  =  330;
		Offset[2]  =  24;
		Offset[3]  =  0;
		Offset[4]  =  300;
		Offset[5]  =  330;
		RenderFlag = -1;
		
		audio_bgm_play(PriorityLow, ActClear, 0, 0);
	}
	
	// Else redirect to special stage
	else switch Game.Emeralds
	{
		/* Add redirection here */
		default:
			room_goto(Stage_SStageTemplate);
		break;
	}
}