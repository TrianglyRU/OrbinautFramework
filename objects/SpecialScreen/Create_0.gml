/// @description Startup
// You can write your code in this editor
	
	State       = 0;
	RoomTimer   = 0;
	RenderFlag  = 0;
	RenderAlpha = 0;
	
	// If coming back from special stage, set offsets and play music
	if global.SpecialState
	{
		Offset[0]  = -330;
		Offset[1]  =  330;
		Offset[2]  =  24;
		Offset[3]  =  0;
		Offset[4]  =  300;
		Offset[5]  =  330;
		RenderFlag = -1;
		
		audio_bgm_play(AudioPrimary, ActClear);
	}
	
	// Else redirect to Special Stage
	else 
	{
		switch global.Emeralds
		{
			default:
				room_goto(SStage_Template);
		}
		fade_perform(ModeInto, BlendWhite, 0);
	}