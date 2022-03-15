/// @description Startup / Setup
// You can call your scripts in this editor
		
	#region Startup
	{
		ColourSet    = [];
		Duration     = [];
		SwapTime     = [];
		Sequence     = [];
		FadeStep     = 756;
		FadeMode     = 1;
		FadeBlend    = 0;
		FadeSpeed    = 0;
		depth		 = 10000; // This is used to perform Draw event earlier than Background Draw event
	
		// Initialise palette animation storage
		for (var i = 0; i < PalLimit; i++)
		{
			for (var j = 0; j < PalLimit; j++)
			{
				Duration[i, j] = noone;
				Sequence[i, j] = noone;
				SwapTime[i, j] = noone;
			}	
			IndexType1[i] = 1;
			IndexType2[i] = 1;
		}
	}
	#endregion
	
	#region Setup
	{
		switch room 
		{
			case Stage_TSZ:
			{
				palette_load(PalPrimary,   pal_tz_type1);
				palette_load(PalSecondary, pal_tz_type2);
			}
			break;
			default:
			{
				palette_load(PalPrimary,   noone);
				palette_load(PalSecondary, noone);
			}
		}
	}
	#endregion