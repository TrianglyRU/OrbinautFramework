function PaletteStartup()
{	
	// Initialise variables
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